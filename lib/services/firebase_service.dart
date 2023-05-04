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

Future<void> addNewUser(
  String email, String name, String username, String password, String salt) async {
  final userRef = db.collection('user');
  final userDocRef = await userRef.add({
    'email': email,
    'name': name,
    'username': username,
    'password': password,
    'salt': salt,
    'followers' : 0,
    'follows' : 0,
  });
  
  // Añado una sub-collection
  final recetasRef = userDocRef.collection('recetas');
  await recetasRef.add({
  });
}

//TODO 
Future<void> addNewRecepie(
  String titulo, int tiempo, String categorias, int raciones, List<String> pasos) async {
  final recetasRef = db.collection('recetas');
  final recetasDocRef = await recetasRef.add({
    'titulo': titulo,
    'tiempo': tiempo,
    'categorias': categorias,
    'raciones': raciones,
    'pasos': pasos,
  });

  // Añado una sub-collection
  final ingredientesRef = recetasDocRef.collection('ingredientes');
  await ingredientesRef.add({

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


Future<String> getSaltByUsername(String username) async {
  QuerySnapshot snapshot = await db
      .collection('user')
      .where('username', isEqualTo: username)
      .get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.get('salt');
  } else {
    throw Exception('User with username $username not found!');
  }
}
