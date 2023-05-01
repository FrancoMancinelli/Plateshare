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
  QuerySnapshot snapshot = await db
      .collection('user')
      .where('username', isEqualTo: username)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<bool> checkIfEmailExists(String email) async {
  QuerySnapshot snapshot = await db
      .collection('user')
      .where('email', isEqualTo: email)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<void> addNewUser(String email, String name, String username, String password) async {
  await db.collection('user').add({
    'email': email,
    'name': name,
    'username': username,
    'password': password,
  });
}

