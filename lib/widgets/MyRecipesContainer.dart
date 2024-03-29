import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/ProfileRecipes.dart';

import '../screens/RecipeFormScreenOne.dart';

class MyRecipesContainer extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String ownerId;

  final String userId;
  final List<String> recipesIDs;

  const MyRecipesContainer({
    Key? key,
    required this.userId,
    required this.recipesIDs,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.ownerId,
  }) : super(key: key);

  @override
  _MyRecipesContainerState createState() => _MyRecipesContainerState();
}

dynamic screenSize;

class _MyRecipesContainerState extends State<MyRecipesContainer> {
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
            if (widget.recipesIDs.isEmpty && widget.userId == widget.ownerId)
              Column(
                children: [
                  Lottie.network(
                    'https://assets6.lottiefiles.com/private_files/lf30_gctc76jz.json',
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    'Aun no hay recetas',
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        color: AppColors.brownInfoRecipe,
                        fontFamily: 'Acme',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes tu primer receta? ',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: AppColors.brownInfoRecipe,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeFormScreenOne(
                                  emailData: widget.emailData,
                                  nameData: widget.nameData,
                                  profilePicData: widget.profilePicData,
                                  usernameData: widget.usernameData),
                            ),
                          );
                        },
                        child: Text(
                          'Click aquí',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 19,
                              color: AppColors.primaryColor,
                              fontFamily: 'Acme',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            if (widget.recipesIDs.isEmpty && widget.userId != widget.ownerId)
              Column(
                children: [
                  Lottie.network(
                    'https://assets6.lottiefiles.com/private_files/lf30_gctc76jz.json',
                    width: 250,
                    height: 250,
                  ),
                  Text(
                    '¡Ups! Aun no se han publicado recetas',
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        color: AppColors.brownInfoRecipe,
                        fontFamily: 'Acme',
                      ),
                    ),
                  ),
                ],
              ),
            for (int i = 0; i < widget.recipesIDs.length; i += 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ProfileRecipes(
                        idRecepieInDatabase: widget.recipesIDs[i],
                        userImage: widget.profilePicData,
                        userName: widget.nameData,
                        userUsername: widget.usernameData,
                        screenWidth: screenSize.width,
                        userId: widget.userId,
                        userEmail: widget.emailData,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if (i + 1 < widget.recipesIDs.length)
                        ProfileRecipes(
                          idRecepieInDatabase: widget.recipesIDs[i + 1],
                          userImage: widget.profilePicData,
                          userName: widget.nameData,
                          userUsername: widget.usernameData,
                          screenWidth: screenSize.width,
                          userId: widget.userId,
                          userEmail: widget.emailData,
                        ),
                      if (i + 1 >= widget.recipesIDs.length)
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
