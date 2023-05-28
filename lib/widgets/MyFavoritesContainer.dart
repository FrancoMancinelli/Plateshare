import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetails.dart';
import 'package:plateshare/screens/RecipeFormScreenOne.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/ProfileRecipes.dart';

class MyFavoritesContainer extends StatefulWidget {
  final String nameData;
  final String usernameData;
  final String profilePicData;

  final List<dynamic> likedRecipesIDs;

  const MyFavoritesContainer({
    Key? key,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.likedRecipesIDs,
  }) : super(key: key);

  @override
  _MyFavoritesContainerState createState() => _MyFavoritesContainerState();
}

var screenSize;

class _MyFavoritesContainerState extends State<MyFavoritesContainer> {
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Container(
      color: AppColors.accentColor,
      width: screenSize.width,
      height: screenSize.height / 1.98,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.likedRecipesIDs.isEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: [
                    Image.network(
                      'https://i.imgur.com/csJDysq.png',
                      width: 150, // Adjust the width as needed
                      height: 150, // Adjust the height as needed
                    ),
                    Text(
                      'Aun no has guardado ninguna receta',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          fontSize: 21,
                          color: AppColors.brownInfoRecipe,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            for (int i = 0; i < widget.likedRecipesIDs.length; i += 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ProfileRecipes(
                        idRecepieInDatabase: widget.likedRecipesIDs[i],
                        userImage: widget.profilePicData,
                        userName: widget.usernameData,
                        userUsername: widget.nameData,
                        screenWidth: screenSize.width,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if (i + 1 < widget.likedRecipesIDs.length)
                        ProfileRecipes(
                          idRecepieInDatabase: widget.likedRecipesIDs[i + 1],
                          userImage: widget.profilePicData,
                          userName: widget.usernameData,
                          userUsername: widget.nameData,
                          screenWidth: screenSize.width,
                        ),
                      if (i + 1 >= widget.likedRecipesIDs.length)
                        Container(
                          width: screenSize.width / 2,
                          height: 245,
                          color: AppColors.accentColor,
                        ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}