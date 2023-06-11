import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/Ingredient.dart';
import '../models/MyNotification.dart';
import '../models/Recipe.dart';
import '../models/User.dart';
import '../models/Comments.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Comprueba que las credenciales de un usuario sean validad
Future<bool> checkCredentials(String username, String password) async {
  QuerySnapshot snapshot = await db
      .collection('user')
      .where('username', isEqualTo: username)
      .where('password', isEqualTo: password)
      .get();
  return snapshot.docs.isNotEmpty;
}

// Comprueba si el nombre de usuario existe
Future<bool> checkIfUsernameExists(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  return snapshot.docs.isNotEmpty;
}

// Comprueba si el email existe
Future<bool> checkIfEmailExists(String email) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('email', isEqualTo: email).get();
  return snapshot.docs.isNotEmpty;
}

// Añade un nuevo usuario
Future<void> addNewUser(String email, String name, String username,
    String password, String salt) async {
  final userRef = db.collection('user');
  final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  await userRef.add({
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

// Actualiza la contraseña de un usuario
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

//Obtiene el nombre de un usuario a parti de su username
Future<String> getNameByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('name');
  } else {
    throw Exception('User with username $username not found!');
  }
}

// Obtiene el email de un usuario a partir de su username
Future<String> getEmailByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('email');
  } else {
    throw Exception('User with username $username not found!');
  }
}

// Obtiene la imegen de un usuario a partir de su username
Future<String> getProfilePicByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('profilepic');
  } else {
    throw Exception('User with username $username not found!');
  }
}

// Obtiene la salt de un usuario a partir de su username
Future<String> getSaltByUsername(String username) async {
  QuerySnapshot snapshot =
      await db.collection('user').where('username', isEqualTo: username).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('salt');
  } else {
    throw Exception('User with username $username not found!');
  }
}

// Obtiene el ID del document a partir de un usuario
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

// Agrega una receta a un usuario
Future<void> addRecipeToUser(String username, Map<String, dynamic> recipeData,
    List<String> ingredientList) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(username);
  final recipeRef = userRef.collection('recipe').doc();

  await recipeRef.set(recipeData);

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

// Obtiene una lista de recetas que pertenezcan a una categoría
Future<List<String>> getRecipesFromCategory(String categoryToFilter) async {
  final QuerySnapshot usersSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  final List<String> categoryRecipes = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final CollectionReference recipeCollectionRef =
        userDoc.reference.collection('recipe');

    final QuerySnapshot recipesSnapshot = await recipeCollectionRef.get();

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

// Obtiene una lista de recetas que lleven menos de 15 minutos de preparación
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

// Obtiene una lista de recetas que lleven 3 ingredientes solamente
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

// Obtiene la información de un usuario a partir de una receta
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

  return [];
}

// Obtiene los datos de una receta
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
      final String rations = recipeData['rations'].toString();

      fields.addAll([image, title, time, rate, rations]);
      break;
    }
  }

  return fields;
}

// Obtiene los ingredientes de una receta
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
      break;
    }
  }

  return ingredients;
}

// Obtiene los comentarios de una receta
Future<List<Map<String, dynamic>>> getRecipeComments(String recipeId) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  List<Map<String, dynamic>> comentarios = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final QuerySnapshot commentSnapshot =
          await recipeSnapshot.reference.collection('comment').get();

      comentarios = commentSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      comentarios.sort((a, b) {
        final DateFormat format = DateFormat("MM/dd/yyyy HH:mm:ss");
        final DateTime dateA = format.parse(a['date'] as String);
        final DateTime dateB = format.parse(b['date'] as String);
        return dateB.compareTo(dateA);
      });

      break;
    }
  }

  return comentarios;
}

// Obtiene los pasos a seguir de una receta
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
      break;
    }
  }

  return steps;
}

// Obtiene el username de un usuario a partir de su id
Future<String?> getUserUsernameByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['username'] as String?;
  }

  return username;
}

// Obtiene la imagen de un usuario a partir de su id
Future<String?> getUserImageByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['profilepic'] as String?;
  }

  return username;
}

// Obtiene el nombre de un usuario a partir de su id
Future<String?> getUserNameByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('user').doc(documentId).get();

  if (snapshot.exists) {
    username = snapshot.data()?['name'] as String?;
  }

  return username;
}

// Agrega un comentario a una receta
Future<void> addCommentToRecipe(
    String recipeId, String owner, String text) async {
  final QuerySnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot =
        await userDoc.reference.collection('recipe').doc(recipeId).get();

    if (recipeSnapshot.exists) {
      final DateTime currentDate = DateTime.now();
      final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
      final String formattedDate = formatter.format(currentDate);

      await recipeSnapshot.reference.collection('comment').add({
        'owner': owner,
        'text': text,
        'date': formattedDate,
      });
      break;
    }
  }
}

// Comprueba si la receta ha sido likeada por un usuario
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
        return true;
      }
    }
  }

  return false;
}

// Añade o quita el like a una receta
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

      break;
    }
  }
}

// Devuelve la cantidad de likes de una receta
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

// Obtiene todas las receta a partir del id de un usuario
Future<List<String>> getRecipeDocumentIDs(String userID) async {
  List<String> recipeIDs = [];

  try {
    CollectionReference userRecipeCollection = FirebaseFirestore.instance
        .collection('user')
        .doc(userID)
        .collection('recipe');

    QuerySnapshot snapshot = await userRecipeCollection.get();

    snapshot.docs.forEach((doc) {
      recipeIDs.add(doc.id);
    });
  } catch (e) {
//
  }

  return recipeIDs;
}

// Obtiene los seguidoress de un usuario
Future<List<dynamic>> getFollowers(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> followers = userData['followers'] ?? [];

  return followers;
}

// Obtiene los seguidos de un usuario
Future<List<dynamic>> getFollows(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> followers = userData['follows'] ?? [];

  return followers;
}

// Obtiene las recetas likeadas por un usuario
Future<List<dynamic>> getLikedRecipes(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('user').doc(userId).get();

  Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
  List<dynamic> favorites = userData['favorites'] ?? [];

  List<dynamic> existingRecipes = [];

  for (var recipeId in favorites) {
    DocumentSnapshot recipeSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .collection('recipe')
        .doc(recipeId)
        .get();

    if (recipeSnapshot.exists) {
      existingRecipes.add(recipeId);
    }
  }

  return existingRecipes;
}

// Añade una receta como favorita
Future<void> addFavorite(String userId, String favoriteId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['favorites'] as List<dynamic>?;

  favorites ??= [];
  favorites.add(favoriteId);

  await userRef.update({'favorites': favorites});
}

// Elimina una receta de favoritos
Future<void> removeFavorite(String userId, String favoriteId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['favorites'] as List<dynamic>?;

  if (favorites != null) {
    favorites.remove(favoriteId);
  }

  await userRef.update({'favorites': favorites});
}

// Añade una nueva notificacion a un usuario
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

// Obtiene todas las notificaciones de un usuario
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
    return [];
  }

  final QuerySnapshot notificationSnapshot =
      await notificationCollectionRef.get();

  final List<Map<String, dynamic>> notifications = [];

  for (final DocumentSnapshot notificationDoc in notificationSnapshot.docs) {
    final Map<String, dynamic>? data =
        notificationDoc.data() as Map<String, dynamic>?;
    if (data != null) {
      data['id'] = notificationDoc.id;
      notifications.add(data);
    }
  }

  return notifications;
}

// Elimina todas las notificaciones de un usuario
Future<void> deleteAllNotifications(String userId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final notificationRef = userRef.collection('notification');

    final collectionSnapshot = await notificationRef.get();

    if (collectionSnapshot.docs.isNotEmpty) {
      final batch = FirebaseFirestore.instance.batch();

      for (final doc in collectionSnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    }
  } catch (error) {
    //
  }
}

// Elimina una notificacion en concreto del usuario
Future<void> deleteNotification(String userId, String notificationId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final notificationRef =
        userRef.collection('notification').doc(notificationId);

    await notificationRef.delete();
  } catch (error) {
    //
  }
}

// Actualiza o añade la valoracion de un usuario a una rectea
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
          List<Map<String, dynamic>>.from(
              (recipeSnapshot.data() as Map<String, dynamic>)['ratings'] ?? []);

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
        ratings[existingRatingIndex]['points'] = rate;
      } else {
        ratings.add(newRating);
      }

      await recipeRef.update({
        'ratings': ratings,
      });
    }
  } catch (error) {
    //
  }
}

// Elimina la valoracion de un usuario a una receta
Future<void> removeUserRatingFromRecipe(
    String ownerId, String recipeId, String userId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(ownerId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    final DocumentSnapshot recipeSnapshot = await recipeRef.get();

    if (recipeSnapshot.exists) {
      final List<Map<String, dynamic>> ratings =
          List<Map<String, dynamic>>.from(recipeSnapshot['ratings'] ?? []);

      ratings.removeWhere((rating) => rating['userid'] == userId);

      final updatedRatings =
          ratings.map((rating) => Map<String, dynamic>.from(rating)).toList();

      await recipeRef.update({
        'ratings': updatedRatings,
      });
    }
  } catch (error) {
    //
  }
}

// Obtiene el puntaje de todas las valoraciones de una receta
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

      final List<double> allRatings =
          ratings.map<double>((rating) => rating['points'] as double).toList();

      return allRatings;
    }

    return [];
  } catch (error) {
    return [];
  }
}

// Actualiza el puntaje total de una receta
Future<void> updateRecipeRating(
    String ownerId, String recipeId, double newRate) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(ownerId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    await recipeRef.update({
      'rate': newRate,
    });
  } catch (error) {
    //
  }
}

// Elimina una receta
Future<void> deleteRecipe(String userId, String recipeId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
    final recipeRef = userRef.collection('recipe').doc(recipeId);

    await recipeRef.delete();
  } catch (error) {
    //
  }
}

// Elimina las colleciones dentro de una receta
Future<void> deleteCollections(String userId, String recipeId) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(userId);
  final recipeRef = userRef.collection('recipe').doc(recipeId);

  final ingredientCollectionRef = recipeRef.collection('ingredient');
  final ingredientDocs = await ingredientCollectionRef.get();
  for (final doc in ingredientDocs.docs) {
    await doc.reference.delete();
  }
  try {
    final commentCollectionRef = recipeRef.collection('comment');
    final commentDocs = await commentCollectionRef.get();
    for (final doc in commentDocs.docs) {
      await doc.reference.delete();
    }
  } catch (error) {
    //
  }
}

// Obtiene la fecha de creación de un usuario
Future<String> getCreationDate(String userId) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data != null && data.containsKey('creationdate')) {
        final String creationDate = data['creationdate'];
        return creationDate;
      }
    }
  } catch (error) {
//
  }

  return '';
}

// Actualiza el nombre de un usuario
Future<void> updateUserName(String userId, String newName) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(userId);

  try {
    await userRef.update({'name': newName});
  } catch (error) {
    //
  }
}

// Actualiza el username de un usuario
Future<void> updateUserUsername(String userId, String newName) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(userId);

  try {
    await userRef.update({'username': newName});
  } catch (error) {
//
  }
}

// Actualiza la foto de perfil de un usuario
Future<void> updateProfilePic(String userId, String newProfilePic) async {
  final userRef = FirebaseFirestore.instance.collection('user').doc(userId);

  try {
    await userRef.update({
      'profilepic': newProfilePic,
    });
  } catch (e) {
    //
  }
}

// Agrega un follower a un usuario
Future<void> addFollower(String userId, String followerId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['followers'] as List<dynamic>?;

  favorites ??= [];
  favorites.add(followerId);

  await userRef.update({'followers': favorites});
}

// Elimina un follower a un usuario
Future<void> removeFollower(String userId, String followerId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? followers = (userSnapshot.data()
      as Map<String, dynamic>)['followers'] as List<dynamic>?;

  if (followers != null) {
    followers.remove(followerId);
  }

  await userRef.update({'followers': followers});
}

// Agrega un usuario a los seguidos de un usuario
Future<void> addMyFollows(String userId, String followId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? follows = (userSnapshot.data()
      as Map<String, dynamic>)['follows'] as List<dynamic>?;

  follows ??= [];
  follows.add(followId);

  await userRef.update({'follows': follows});
}

// Elimina un usuario de los seguidos de un usuario
Future<void> removeMyFollows(String userId, String followId) async {
  DocumentReference userRef =
      FirebaseFirestore.instance.collection('user').doc(userId);

  DocumentSnapshot userSnapshot = await userRef.get();
  List<dynamic>? favorites = (userSnapshot.data()
      as Map<String, dynamic>)['follows'] as List<dynamic>?;

  if (favorites != null) {
    favorites.remove(followId);
  }

  await userRef.update({'follows': favorites});
}

// Comprueba si un usuario sigue a otro
Future<bool> checkIfFollowsExist(String userId, String searchString) async {
  try {
    final userDoc =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();
    final follows = userDoc.data()?['follows'] as List<dynamic>?;

    if (follows != null && follows.contains(searchString)) {
      return true;
    }

    return false;
  } catch (e) {
    return false;
  }
}

// Obtiene TODOS los usuarios de la base de datos 
Future<List<User>> getUsers() async {
  List<User> userList = [];

  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
    List<Recipe> recipesList = [];
    List<MyNotification> notificationsList = [];

    try {
      QuerySnapshot<Map<String, dynamic>> recipeSnapshot =
          await doc.reference.collection('recipe').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> recipeDoc
          in recipeSnapshot.docs) {
        List<Ingredient> ingredientsList = [];
        List<Comments> commentsList = [];

        QuerySnapshot<Map<String, dynamic>> ingredientSnapshot =
            await recipeDoc.reference.collection('ingredient').get();

        for (QueryDocumentSnapshot<Map<String, dynamic>> ingredientDoc
            in ingredientSnapshot.docs) {
          Ingredient ingredient = Ingredient(
            name: ingredientDoc.get('name'),
            type: ingredientDoc.get('type'),
            amount: ingredientDoc.get('amount'),
          );

          ingredientsList.add(ingredient);
        }

        try {
          QuerySnapshot<Map<String, dynamic>> commentSnapshot =
              await recipeDoc.reference.collection('comment').get();

          for (QueryDocumentSnapshot<Map<String, dynamic>> commentDoc
              in commentSnapshot.docs) {
            Comments comment = Comments(
              date: commentDoc.get('date'),
              owner: commentDoc.get('owner'),
              text: commentDoc.get('text'),
            );

            commentsList.add(comment);
          }
        } catch (e) {
          //
        }

        Recipe recipe = Recipe(
          id: recipeDoc.id,
          titulo: recipeDoc.get('title'),
          imagen: recipeDoc.get('image'),
          rate: recipeDoc.get('rate'),
          rations: recipeDoc.get('rations'),
          time: recipeDoc.get('time'),
          steps: List<String>.from(recipeDoc.get('steps')),
          comments: commentsList,
          ingredientes: ingredientsList,
          categories: List<String>.from(recipeDoc.get('category')),
          likes: [],
        );

        recipesList.add(recipe);
      }
    } catch (e) {
      //
    }

    try {
      QuerySnapshot<Map<String, dynamic>> notificationSnapshot =
          await doc.reference.collection('notification').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> notificationDoc
          in notificationSnapshot.docs) {
        MyNotification notification = MyNotification(
          id: notificationDoc.id,
          data: notificationDoc.get('data'),
          type: notificationDoc.get('type'),
          date: notificationDoc.get('date'),
          image: notificationDoc.get('image'),
          usernotifier: notificationDoc.get('usernotifier'),
        );
        notificationsList.add(notification);
      }
    } catch (e) {
      //
    }

    User user = User(
      id: doc.id,
      email: doc.get('email'),
      favorites: List<String>.from(doc.get('favorites')),
      followers: List<String>.from(doc.get('followers')),
      follows: List<String>.from(doc.get('follows')),
      name: doc.get('name'),
      password: doc.get('password'),
      profilepic: doc.get('profilepic'),
      salt: doc.get('salt'),
      username: doc.get('username'),
      recipes: recipesList,
      fechaCreacion: doc.get('creationdate'),
      notifications: notificationsList,
    );
    userList.add(user);
  }

  return userList;
}

// Busca recetas a partir de sus ingredientes
Future<List<String>> searchRecipesByIngredients(
    List<String> ingredientNames) async {
  List<String> recipeIds = [];

  QuerySnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc
      in userSnapshot.docs) {
    QuerySnapshot<Map<String, dynamic>> recipeSnapshot =
        await userDoc.reference.collection('recipe').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> recipeDoc
        in recipeSnapshot.docs) {
      QuerySnapshot<Map<String, dynamic>> ingredientSnapshot =
          await recipeDoc.reference.collection('ingredient').get();

      Set<String> matchedIngredientNames = Set<String>.from(ingredientNames);

      for (QueryDocumentSnapshot<Map<String, dynamic>> ingredientDoc
          in ingredientSnapshot.docs) {
        String ingredientName = ingredientDoc.get('name');

        matchedIngredientNames.remove(ingredientName);

        if (matchedIngredientNames.isEmpty) {
          recipeIds.add(recipeDoc.id);
          break;
        }
      }
    }
  }

  return recipeIds;
}

// Busca recetas a partir de su titulo
Future<List<String>> searchRecipesByTitle(String searchString) async {
  List<String> recipeIds = [];

  try {
    QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('user').get();

    for (DocumentSnapshot<Map<String, dynamic>> userDoc in userSnapshot.docs) {
      CollectionReference<Map<String, dynamic>> recipeCollectionRef =
          userDoc.reference.collection('recipe');

      QuerySnapshot<Map<String, dynamic>> recipeSnapshot =
          await recipeCollectionRef.get();

      for (DocumentSnapshot<Map<String, dynamic>> recipeDoc
          in recipeSnapshot.docs) {
        String title = recipeDoc.get('title');

        if (title.toLowerCase().contains(searchString.toLowerCase())) {
          recipeIds.add(recipeDoc.id);
        }
      }
    }
  } catch (e) {
    //
  }

  return recipeIds;
}

// Busca un usuario a partir de su username
Future<List<String>> searchUsersByUsername(String searchString) async {
  List<String> userDocIds = [];

  QuerySnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('user').get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc
      in userSnapshot.docs) {
    String username = userDoc.get('username');

    if (username.toLowerCase().startsWith(searchString.toLowerCase())) {
      userDocIds.add(userDoc.id);
    }
  }

  return userDocIds;
}

// Obtiene la data de un usuario a partir de su ID
Future<DocumentSnapshot> getUserDataById(String userId) async {
  try {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();
    return snapshot;
  } catch (e) {
    rethrow;
  }
}