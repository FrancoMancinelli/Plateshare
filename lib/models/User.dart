import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plateshare/models/Recipe.dart';

class User {
  String email;
  String name;
  String username;
  String password;
  String salt;
  String followers;
  String follows;
  List<Recipe> recipes;

  User({
    required this.email,
    required this.name,
    required this.username,
    required this.password,
    required this.salt,
    required this.recipes,
    required this.followers,
    required this.follows,
  });

}


