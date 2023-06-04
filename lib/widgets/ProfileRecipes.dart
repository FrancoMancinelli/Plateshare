import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetails.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

import '../models/Ingredient.dart';

class ProfileRecipes extends StatefulWidget {
  final String idRecepieInDatabase;
  final String userImage;
  final String userName;
  final String userUsername;
  final double screenWidth;
  final String userId;
  final String userEmail;

  const ProfileRecipes({
    Key? key,
    required this.idRecepieInDatabase,
    required this.userImage,
    required this.userName,
    required this.userUsername,
    required this.screenWidth,
    required this.userId, required this.userEmail,
  }) : super(key: key);

  @override
  _ProfileRecipesState createState() => _ProfileRecipesState();
}

class _ProfileRecipesState extends State<ProfileRecipes> {
  String title = "Default data information";
  String time = "0";
  String rate = "0.0";
  String image =
      "https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_recipeimage.jpg?alt=media&token=8400f8d3-7704-4a54-8151-da4053cf9102";
  int likes = 0;
  String rations = "0";
  List<String> steps = [];
  String ownerImage =
      "https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_recipeimage.jpg?alt=media&token=8400f8d3-7704-4a54-8151-da4053cf9102";
  String ownerUsername = "username";
  List<Ingredient> ingredients = [];
  List<Map<String, dynamic>> comentarios = [];
  bool isFavorite = true;

  @override
  void initState() {
    super.initState();
    fetchRecipeData();
  }

  Future<void> fetchRecipeData() async {
    final recipeData = await getRecipeFields(widget.idRecepieInDatabase);
    final recipeSteps = await getRecipeSteps(widget.idRecepieInDatabase);
    final recipeOwner = await getUserInfoFromRecipe(widget.idRecepieInDatabase);
    final recipeIngredients = await getRecipeIngredients(widget.idRecepieInDatabase);
    final formattedIngredients = formatIngredients(recipeIngredients);
    final recipeComments = await getRecipeComments(widget.idRecepieInDatabase);
    final ownerId = await getDocumentIdByUsername(recipeOwner[1]);

    final likesCount =
        await getAmountOfLikes(ownerId, widget.idRecepieInDatabase);

    if (mounted) {
      if (recipeData.isNotEmpty) {
        setState(() {
          if (recipeData[0].isNotEmpty) {
            image = recipeData[0];
          }
          title = recipeData[1];
          time = recipeData[2];
          rate = recipeData[3];
          rations = recipeData[4];
          steps = addIndexToItems(recipeSteps);
          ownerImage = recipeOwner[0];
          ownerUsername = recipeOwner[1];
          ingredients = formattedIngredients;
          comentarios = recipeComments;
          likes = likesCount;
        });
      }
    }
  }

  List<Ingredient> formatIngredients(
      List<Map<String, dynamic>> ingredientList) {
    List<Ingredient> ingredients = [];

    for (var ingredient in ingredientList) {
      String name = ingredient['name'] as String;
      String type = ingredient['type'] as String;
      int amount = int.parse(ingredient['amount'] as String);

      Ingredient formattedIngredient = Ingredient(
        name: name,
        type: type,
        amount: amount,
      );

      ingredients.add(formattedIngredient);
    }

    return ingredients;
  }

  List<String> addIndexToItems(List<String> items) {
    return items.asMap().entries.map((entry) {
      int index = entry.key + 1;
      String item = entry.value;
      return '$index.- $item';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailsScreen(
                recipeID: widget.idRecepieInDatabase,
                recipeImage: image,
                recipeRate: rate,
                recipeTime: time,
                recipeTitle: title,
                recipeLikes: likes,
                recipeRations: int.parse(rations),
                recipeSteps: steps,
                ownerImage: ownerImage,
                ownerUsername: ownerUsername,
                recipeIngredients: ingredients,
                userId: widget.userId,
                userImage: widget.userImage,
                userName: widget.userName,
                userUsername: widget.userUsername,
                recipeComments: comentarios,
                isFavorite: isFavorite, userEmail: widget.userEmail,),
          ),
        );
      },
      child: Container(
        width: widget.screenWidth/2,
        height: 245,
        decoration: BoxDecoration(
          color: AppColors.brownRecepieColor,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: AppColors.greyColor,
            width: 0.5
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //IMAGEN IMAGEN IMAGEN IMAGEN
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Container(
                width: 182,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image,
                    width: 200,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            //PUNTUACION Y HORA | PUNTUACION Y HORA
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Icon(Icons.star_rounded, color: Colors.white, size: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 2, 0, 0),
                    child: Text(
                      rate,
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.access_time,
                        color: Colors.white, size: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 0, 0),
                    child: Text(
                      '$time mins',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // NOMBRE DE RECETA
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment
                          .topLeft, // Align the text at the top and left
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
                        child: Text(
                          title,
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Acme',
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
