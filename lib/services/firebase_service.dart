import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<bool> checkCredentials(String username, String password) async {
  QuerySnapshot snapshot = await db
      .collection('user')
      .where('username', isEqualTo: username)
      .where('password', isEqualTo: password)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<bool> checkIfUsernameExists(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  return snapshot.docs.isNotEmpty;
}

Future<bool> checkIfEmailExists(String email) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('email', isEqualTo: email).get();
  return snapshot.docs.isNotEmpty;
}


Future<void> addNewUser(String email, String name, String username,
    String password, String salt) async {
  final userRef = db.collection('user');
  final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  final userDocRef = await userRef.add({
    'email': email,
    'name': name,
    'username': username,
    'password': password,
    'salt': salt,
    'followers': [],
    'follows': [],
    'favorites': [],
    'profilepic':
        'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_profile_pic.png?alt=media&token=92c2e8f1-5871-4285-8040-8b8df60bae14',
    'creationdate': currentDate,
  });
}



Future<void> updateUserPasswordByUsername(
    String username, String newPassword) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    String userId = snapshot.docs.first.id;
    await db.collection('user').doc(userId).update({
      'password': newPassword,
    });
  } else {
    throw Exception('User with username $username not found!');
  }
}

Future<String> getNameByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('name');
  } else {
    throw Exception('User with username $username not found!');
  }
}

Future<String> getEmailByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('email');
  } else {
    throw Exception('User with username $username not found!');
  }
}

Future<String> getProfilePicByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('profilepic');
  } else {
    throw Exception('User with username $username not found!');
  }
}

Future<String> getSaltByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('salt');
  } else {
    throw Exception('User with username $username not found!');
  }
}

Future<String> getDocumentIdByUsername(String username) async {
  String documentId = '';

  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('user')
      .where('username', isEqualTo: username)
      .get();

  if (snapshot.size > 0) {
    documentId = snapshot.docs[0].id;
  }

  return documentId;
}

Future<void> addRecipeToUser(String username, Map<String, dynamic> recipeData,
    List<String> ingredientList) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(username);
  final recipeRef = userRef.collection('recipe').doc();

  // Add recipe data to the 'recipe' document
  await recipeRef.set(recipeData);

  // Create 'ingredients' collection and add documents
  final ingredientsRef = recipeRef.collection('ingredient');
  for (String ingredient in ingredientList) {
    List<String> parts = ingredient.split(' - ');

    if (parts.length == 2) {
      String text1 = parts[0].trim();
      String numberText = parts[1].trim();

      RegExp numberRegex = RegExp(r'\d+');
      String number = numberRegex.firstMatch(numberText)?.group(0) ?? '';
      String text2 = numberText.replaceFirst(numberRegex, '').trim();

      final ingredientData = {
        'amount': number,
        'name': text1,
        'type': text2,
      };

      await ingredientsRef.add(ingredientData);
    }
  }
}

Future<List<String>> getRecipesFromCategory(String categoryToFilter) async {
  final QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  final List<String> categoryRecipes = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final CollectionReference recipeCollectionRef =
        userDoc.reference.collection('recipe');

    final QuerySnapshot recipesSnapshot = await recipeCollectionRef.get();

    // Check if the 'recipe' collection exists and has any documents
    if (recipesSnapshot.docs.isNotEmpty) {
      for (final DocumentSnapshot recipeDoc in recipesSnapshot.docs) {
        final List<dynamic> categories = recipeDoc.get('category');
        if (categories != null && categories.contains(categoryToFilter)) {
          categoryRecipes.add(recipeDoc.id);
        }
      }
    }
  }

  return categoryRecipes;
}

Future<List<String>> getRecepiesLessThan15Min() async {
  final QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  final List<String> recipiesWithShortTime = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final QuerySnapshot recepiesSnapshot =
        await userDoc.reference.collection('recipe').get();

    for (final DocumentSnapshot recepieDoc in recepiesSnapshot.docs) {
      final int tiempo = recepieDoc.get('time');
      if (tiempo != null && tiempo <= 15) {
        recipiesWithShortTime.add(recepieDoc.id);
      }
    }
  }

  return recipiesWithShortTime;
}

Future<List<String>> getRecipiesWith3Ingredients() async {
  final QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  final List<String> recipiesWithThreeIngredients = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final QuerySnapshot recepiesSnapshot =
        await userDoc.reference.collection('recipe').get();

    for (final DocumentSnapshot recepieDoc in recepiesSnapshot.docs) {
      final QuerySnapshot ingredientesSnapshot =
          await recepieDoc.reference.collection('ingredient').get();

      if (ingredientesSnapshot.size == 3) {
        recipiesWithThreeIngredients.add(recepieDoc.id);
      }
    }
  }

  return recipiesWithThreeIngredients;
}

Future<List<String>> getUserInfoFromRecipe(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final QuerySnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .where(FieldPath.documentId, isEqualTo: recipeId)
        .get();

    if (recipeSnapshot.docs.isNotEmpty) {
      final DocumentSnapshot recipeDoc = recipeSnapshot.docs.first;
      final DocumentSnapshot userRecipeDoc =
          await recipeDoc.reference.parent.parent!.get();

      final Map<String, dynamic> userData =
          userRecipeDoc.data() as Map<String, dynamic>;
      final String image = userData['profilepic'].toString();
      final String username = userData['username'].toString();
      return [image, username];
    }
  }

  return []; // Return an empty list if the recipe document is not found
}

Future<List<String>> getRecipeFields(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  final List<String> fields = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final Map<String, dynamic> recipeData =
          recipeSnapshot.data() as Map<String, dynamic>;

      final String image = recipeData['image'].toString();
      final String title = recipeData['title'].toString();
      final String time = recipeData['time'].toString();
      final String rate = recipeData['rate'].toString();
      //final String likes = recipeData['likes'].toString();
      final String rations = recipeData['rations'].toString();

      fields.addAll([image, title, time, rate, rations]);
      break; // Exit the loop once the recipe document is found
    }
  }

  return fields;
}

Future<List<Map<String, dynamic>>> getRecipeIngredients(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  List<Map<String, dynamic>> ingredients = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final QuerySnapshot ingredientSnapshot =
          await recipeSnapshot.reference.collection('ingredient').get();

      ingredients = ingredientSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      break; // Exit the loop once the recipe document is found
    }
  }

  return ingredients;
}

Future<List<Map<String, dynamic>>> getRecipeComments(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  List<Map<String, dynamic>> comentarios = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final QuerySnapshot ingredientSnapshot =
          await recipeSnapshot.reference.collection('comment').get();

      comentarios = ingredientSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      break; // Exit the loop once the recipe document is found
    }
  }

  return comentarios;
}

Future<List<String>> getRecipeSteps(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  List<String> steps = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final Map<String, dynamic> recipeData =
          recipeSnapshot.data() as Map<String, dynamic>;

      final List<dynamic> stepsData = recipeData['steps'];
      steps = stepsData.cast<String>().toList();
      break; // Exit the loop once the recipe document is found
    }
  }

  return steps;
}

Future<String?> getUserUsernameByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['username'] as String?;
  }

  return username;
}

Future<String?> getUserImageByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['profilepic'] as String?;
  }

  return username;
}

Future<String?> getUserNameByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['name'] as String?;
  }

  return username;
}

Future<void> addCommentToRecipe(
    String recipeId, String owner, String text) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      await recipeSnapshot.reference.collection('comment').add({
        'owner': owner,
        'text': text,
      });
      break; // Exit the loop once the recipe document is found
    }
  }
}

Future<bool> checkIfRecipeLiked(
    String recipeOwner, String recipeId, String value) async {
  final DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
      await FirebaseFirestore.instance
          .collection('user')
          .doc(recipeOwner)
          .collection('recipe')
          .doc(recipeId)
          .get();

  final Map<String, dynamic>? data = recipeSnapshot.data();
  final likes = data?['likes'];

  if (likes != null) {
    if (likes is List<dynamic>) {
      if (likes.contains(value)) {
        // The provided value exists in the 'likes' array
        return true;
      }
    }
  }

  return false;
}

Future<void> modifyLikeToRecipe(String recipeId, String value, int flag) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final Map<String, dynamic>? recipeData = recipeSnapshot.data();

      if (recipeData != null) {
        final List<dynamic> likes = recipeData['likes'] is List<dynamic>
            ? recipeData['likes']
            : <dynamic>[];

        if (!likes.contains(value) && flag == 1) {
          likes.add(value);
          await recipeSnapshot.reference.update({'likes': likes});
        } else if (likes.contains(value) && flag == 2) {
          likes.remove(value);
          await recipeSnapshot.reference.update({'likes': likes});
        }
      }

      break; // Exit the loop once the recipe document is found
    }
  }
}

Future<int> getAmountOfLikes(String recipeOwner, String recipeId) async {
  final DocumentSnapshot<Map<String, dynamic>> recipeSnapshot =
      await FirebaseFirestore.instance
          .collection('user')
          .doc(recipeOwner)
          .collection('recipe')
          .doc(recipeId)
          .get();

  final Map<String, dynamic>? data = recipeSnapshot.data();
  final likes = data?['likes'];

  if (likes != null) {
    if (likes is List<dynamic>) {
      return likes.length;
    }
  }

  return 0;
}

Future<List<String>> getRecipeDocumentIDs(String userID) async {
  List<String> recipeIDs = [];

  try {
    // Get the 'recipe' collection reference inside the user document
    CollectionReference userRecipeCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(userID)
        .collection('recipe');

    // Get all the documents in the 'recipe' collection
    QuerySnapshot snapshot = await userRecipeCollection.get();

    // Extract the document IDs and add them to the list
    snapshot.docs.forEach((doc) {
      recipeIDs.add(doc.id);
    });
  } catch (e) {
    print('Error getting recipe document IDs: $e');
  }

  return recipeIDs;
}

Future<List<dynamic>> getFollowers(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> followers = userData['followers'] ?? [];

  return followers;
}

Future<List<dynamic>> getFollows(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> followers = userData['follows'] ?? [];

  return followers;
}

Future<List<dynamic>> getLikedRecipes(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> favorites = userData['favorites'] ?? [];

  List<dynamic> existingRecipes = [];

  for (var recipeId in favorites) {
    DocumentSnapshot recipeSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      existingRecipes.add(recipeId);
    }
  }

  return existingRecipes;
}

Future<void> addFavorite(String userId, String favoriteId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  // Get the current favorites array
  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['favorites'] as List<dynamic>?;

  // Add the new favorite to the array
  favorites ??= [];
  favorites.add(favoriteId);

  // Update the 'favorites' field with the updated array
  await userRef.update({'favorites': favorites});
}

Future<void> removeFavorite(String userId, String favoriteId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  // Get the current favorites array
  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['favorites'] as List<dynamic>?;

  // Remove the specified favorite from the array
  if (favorites != null) {
    favorites.remove(favoriteId);
  }

  // Update the 'favorites' field with the updated array
  await userRef.update({'favorites': favorites});
}

Future<void> addNewNotification(String userId, String notificationData,
    int type, String userNotifierImage) async {
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('user');

  final DocumentReference userDocRef = userCollectionRef.doc(userId);

  final CollectionReference notificationCollectionRef =
      userDocRef.collection('notification');

  final DateTime currentDate = DateTime.now();

  await notificationCollectionRef.add({
    'image': userNotifierImage,
    'data': notificationData,
    'type': type,
    'date': Timestamp.fromDate(currentDate),
  });
}

Future<List<Map<String, dynamic>>> getAllNotifications(String userId) async {
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection('user');

  final DocumentReference userDocRef = userCollectionRef.doc(userId);

  final CollectionReference notificationCollectionRef =
      userDocRef.collection('notification');

  final bool notificationCollectionExists = await notificationCollectionRef
      .limit(1)
      .get()
      .then((snapshot) => snapshot.size > 0);

  if (!notificationCollectionExists) {
    // The notification collection does not exist or is empty
    return [];
  }

  final QuerySnapshot notificationSnapshot =
      await notificationCollectionRef.get();

  final List<Map<String, dynamic>> notifications = [];

  for (final DocumentSnapshot notificationDoc in notificationSnapshot.docs) {
    final Map<String, dynamic>? data =
        notificationDoc.data() as Map<String, dynamic>?;
    if (data != null) {
      data['id'] = notificationDoc.id; // Include the document ID in the map
      notifications.add(data);
    }
  }

  return notifications;
}

Future<void> deleteAllNotifications(String userId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final notificationRef = userRef.collection('notification');

    final collectionSnapshot = await notificationRef.get();

    if (collectionSnapshot.docs.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();

      // Iterate over each document and add delete operation to the batch
      for (final doc in collectionSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    }
  } catch (error) {
    // Handle the error as per your requirements
  }
}

Future<void> deleteNotification(String userId, String notificationId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final notificationRef =
        userRef.collection('notification').doc(notificationId);

    await notificationRef.delete();
  } catch (error) {
    // Handle the error as per your requirements
  }
}

Future<void> addOrUpdateRatingToRecipe(
  String ownerId,
  String recipeId,
  double rate,
  String userId,
) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(ownerId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    final DocumentSnapshot recipeSnapshot = await recipeRef.get();

    if (recipeSnapshot.exists) {
      final List<Map<String, dynamic>> ratings =
          List<Map<String, dynamic>>.from((recipeSnapshot.data() as Map<String, dynamic>)['ratings'] ?? []);

      int existingRatingIndex = -1;

      for (int i = 0; i < ratings.length; i++) {
        if (ratings[i]['userid'] == userId) {
          existingRatingIndex = i;
          break;
        }
      }

      final newRating = {
        'userid': userId,
        'points': rate,
      };

      if (existingRatingIndex != -1) {
        // User has already rated, update the existing rating
        ratings[existingRatingIndex]['points'] = rate;
      } else {
        // User has not rated, add the new rating
        ratings.add(newRating);
      }

      await recipeRef.update({
        'ratings': ratings,
      });
    }
  } catch (error) {
    // Handle the error as per your requirements
  }
}




Future<void> removeUserRatingFromRecipe(String ownerId, String recipeId, String userId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(ownerId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    final DocumentSnapshot recipeSnapshot = await recipeRef.get();

    if (recipeSnapshot.exists) {
      final List<Map<String, dynamic>> ratings =
          List<Map<String, dynamic>>.from(recipeSnapshot['ratings'] ?? []);

      ratings.removeWhere((rating) => rating['userid'] == userId);

      // Convert the updated ratings list back to a list of dynamic
      final updatedRatings = ratings.map((rating) => Map<String, dynamic>.from(rating)).toList();

      await recipeRef.update({
        'ratings': updatedRatings,
      });
    }
  } catch (error) {
    // Handle the error as per your requirements
  }
}

Future<List<double>> getAllRatings(String userId, String recipeId) async {
  try {
    final recipeRef = FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('recipe')
        .doc(recipeId);

    final DocumentSnapshot recipeSnapshot = await recipeRef.get();

    if (recipeSnapshot.exists) {
      final List<dynamic> ratings = recipeSnapshot['ratings'] ?? [];

      final List<double> allRatings = ratings
          .map<double>((rating) => rating['points'] as double)
          .toList();

      return allRatings;
    }

    return []; // Return an empty list if the recipe does not exist or has no ratings
  } catch (error) {
    // Handle the error as per your requirements
    return []; // Return an empty list in case of an error
  }
}




Future<void> updateRecipeRating(String ownerId, String recipeId, double newRate) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(ownerId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    await recipeRef.update({
      'rate': newRate,
    });
  } catch (error) {
    // Handle the error as per your requirements
  }
}

Future<void> deleteRecipe(String userId, String recipeId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    await recipeRef.delete();

    print('Recipe deleted successfully');
  } catch (error) {
    print('Error deleting recipe: $error');
    // Handle the error as per your requirements
  }
}

Future<void> deleteCollections(String userId, String recipeId) async {
  
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    // Delete the 'ingredient' collection
    final ingredientCollectionRef = recipeRef.collection('ingredient');
    final ingredientDocs = await ingredientCollectionRef.get();
    for (final doc in ingredientDocs.docs) {
      await doc.reference.delete();
    }
try {
    // Delete the 'comment' collection
    final commentCollectionRef = recipeRef.collection('comment');
    final commentDocs = await commentCollectionRef.get();
    for (final doc in commentDocs.docs) {
      await doc.reference.delete();
    }
  } catch (error) {
    // Handle the error as per your requirements
  }
}

Future<String> getCreationDate(String userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('user')
            .doc(userId)
            .get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data.containsKey('creationdate')) {
        final String creationDate = data['creationdate'];
        return creationDate;
      }
    }
  } catch (error) {
    // Handle any errors that occur during the process
    print('Error retrieving creation date: $error');
  }

  return ''; // Return null if the creation date is not found or an error occurs
}





