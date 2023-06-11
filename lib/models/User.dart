
import 'MyNotification.dart';
import 'Recipe.dart';

class User {
   String id;
   String username;
   String email;
   String salt;
   String name;
   String password;
   String profilepic;
   List<String> favorites;
   List<String> followers;
   List<String> follows;
   List<Recipe> recipes;
   String fechaCreacion;
   List<MyNotification> notifications;

User({
    required this.id,
    required this.email,
    required this.favorites,
    required this.followers,
    required this.follows,
    required this.name,
    required this.password,
    required this.profilepic,
    required this.salt,
    required this.username,
    required this.recipes,
    required this.fechaCreacion,
    required this.notifications,
  });
}