import 'package:cloud_firestore/cloud_firestore.dart';

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
  final userDocRef = await userRef.add({
    'email': email,
    'name': name,
    'username': username,
    'password': password,
    'salt': salt,
    'followers': 0,
    'follows': 0,
    'favorites': '',
  });

  // Añado una sub-collection
  final recetasRef = userDocRef.collection('recipe');
  await recetasRef.add({});
}

//TODO
Future<void> addNewRecepie(String titulo, int tiempo, String categorias,
    int raciones, List<String> pasos) async {
  final recetasRef = db.collection('recipe');
  final recetasDocRef = await recetasRef.add({
    'title': titulo,
    'time': tiempo,
    'category': categorias,
    'rations': raciones,
    'steps': pasos,
  });

  // Añado una sub-collection
  final ingredientesRef = recetasDocRef.collection('ingredient');
  await ingredientesRef.add({});
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

  final commentsRef = recipeRef.collection('comment');
  final commentsData = {
    'owner': 'Gm8fyjV8jbQiUDajIE0V',
    'text': '',
  };
  await commentsRef.add(commentsData);
}


Future<List<String>> getRecepiesFromCategory(String categoriaAFiltrar) async {
  final QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  final List<String> calienteRecipies = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final QuerySnapshot recepiesSnapshot =
        await userDoc.reference.collection('recipe').get();

    for (final DocumentSnapshot recepieDoc in recepiesSnapshot.docs) {
      final List<dynamic> categorias = recepieDoc.get('category');
      if (categorias != null && categorias.contains(categoriaAFiltrar)) {
        calienteRecipies.add(recepieDoc.id);
      }
    }
  }
  return calienteRecipies;
}

Future<List<String>> getRecepiesLessThan15Min() async {
  final QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

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
  final QuerySnapshot usersSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  final List<String> recipiesWithThreeIngredients = [];

  for (final DocumentSnapshot userDoc in usersSnapshot.docs) {
    final QuerySnapshot recepiesSnapshot =
        await userDoc.reference.collection('recipe').get();

    for (final DocumentSnapshot recepieDoc in recepiesSnapshot.docs) {
      final QuerySnapshot ingredientesSnapshot = await recepieDoc.reference
          .collection('ingredient')
          .get();

      if (ingredientesSnapshot.size == 3) {
        recipiesWithThreeIngredients.add(recepieDoc.id);
      }
    }
  }

  return recipiesWithThreeIngredients;
}

Future<List<String>> getUserInfoFromRecipe(String recipeId) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final QuerySnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .where(FieldPath.documentId, isEqualTo: recipeId)
        .get();

    if (recipeSnapshot.docs.isNotEmpty) {
      final DocumentSnapshot recipeDoc = recipeSnapshot.docs.first;
      final DocumentSnapshot userRecipeDoc = await recipeDoc.reference.parent.parent!.get();

      final Map<String, dynamic> userData = userRecipeDoc.data() as Map<String, dynamic>;
      final String image = userData['profilepic'].toString();
      final String username = userData['username'].toString();
      print(image);
      print(username);
      return [image, username];
    }
  }

  return []; // Return an empty list if the recipe document is not found
}






Future<List<String>> getRecipeFields(String recipeId) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  final List<String> fields = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .doc(recipeId)
        .get();

    if (recipeSnapshot.exists) {
      final Map<String, dynamic> recipeData =
          recipeSnapshot.data() as Map<String, dynamic>;

      final String image = recipeData['image'].toString();
      final String title = recipeData['title'].toString();
      final String time = recipeData['time'].toString();
      final String rate = recipeData['rate'].toString();
      final String likes = recipeData['likes'].toString();
      final String rations = recipeData['rations'].toString();

      fields.addAll([image, title, time, rate, likes, rations]);
      break; // Exit the loop once the recipe document is found
    }
  }

  return fields;
}

Future<List<Map<String, dynamic>>> getRecipeIngredients(String recipeId) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  List<Map<String, dynamic>> ingredients = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .doc(recipeId)
        .get();

    if (recipeSnapshot.exists) {
      final QuerySnapshot ingredientSnapshot = await recipeSnapshot.reference
          .collection('ingredient')
          .get();

      ingredients = ingredientSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      print(ingredients);
      break; // Exit the loop once the recipe document is found
    }
  }

  return ingredients;
}

Future<List<Map<String, dynamic>>> getRecipeComments(String recipeId) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  List<Map<String, dynamic>> comentarios = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .doc(recipeId)
        .get();

    if (recipeSnapshot.exists) {
      final QuerySnapshot ingredientSnapshot = await recipeSnapshot.reference
          .collection('comment')
          .get();

      comentarios = ingredientSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      break; // Exit the loop once the recipe document is found
    }
  }

  return comentarios;
}


Future<List<String>> getRecipeSteps(String recipeId) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  List<String> steps = [];

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .doc(recipeId)
        .get();

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

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('user')
      .doc(documentId)
      .get();

  if (snapshot.exists) {
    username = snapshot.data()?['username'] as String?;
  }

  return username;
}

Future<String?> getUserImageByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('user')
      .doc(documentId)
      .get();

  if (snapshot.exists) {
    username = snapshot.data()?['profilepic'] as String?;
  }

  return username;
}

Future<String?> getUserNameByDocumentId(String documentId) async {
  String? username;

  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('user')
      .doc(documentId)
      .get();

  if (snapshot.exists) {
    username = snapshot.data()?['name'] as String?;
  }

  return username;
}

Future<void> addCommentToRecipe(String recipeId, String owner, String text) async {
  final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
      .collection('user')
      .get();

  for (final DocumentSnapshot userDoc in userSnapshot.docs) {
    final DocumentSnapshot recipeSnapshot = await userDoc.reference
        .collection('recipe')
        .doc(recipeId)
        .get();

    if (recipeSnapshot.exists) {
      await recipeSnapshot.reference.collection('comment').add({
        'owner': owner,
        'text': text,
      });
      break; // Exit the loop once the recipe document is found
    }
  }
}









