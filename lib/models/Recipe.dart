import 'Ingredient.dart';
import 'Comments.dart';

class Recipe {
   String id;
   String titulo;
   String imagen;
   double rate;
   String rations;
   int time;
   List<String> steps;
   List<Comments> comments;
   List<Ingredient> ingredientes;
   List<String> categories;
   List<String> likes;

Recipe({
    required this.id,
    required this.comments,
    required this.titulo,
    required this.imagen,
    required this.ingredientes,
    required this.rate,
    required this.rations,
    required this.steps,
    required this.time,
    required this.categories,
    required this.likes,
  });
}
