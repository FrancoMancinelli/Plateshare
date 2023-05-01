import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<bool> checkCredentials(String username, String password) async {
  QuerySnapshot snapshot = await db
      .collection('users')
      .where('username', isEqualTo: username)
      .where('password', isEqualTo: password)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<bool> checkIfUsernameExists(String username) async {
  QuerySnapshot snapshot = await db
      .collection('users')
      .where('username', isEqualTo: username)
      .get();
  return snapshot.docs.isNotEmpty;
}

Future<void> addNewUser(String username, String password) async {
  await db.collection('users').add({
    'username': username,
    'password': password,
  });
}

