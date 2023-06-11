import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/ProfileRecipes.dart';

class MyFavoritesContainer extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String userId;
  final String ownerId;

  final List<dynamic> likedRecipesIDs;

  const MyFavoritesContainer({
    Key? key,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.likedRecipesIDs,
    required this.userId,
    required this.emailData, required this.ownerId,
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
            if (widget.likedRecipesIDs.isEmpty && widget.userId == widget.ownerId)
              Column(
                children: [
                  Lottie.network(
                  'https://assets6.lottiefiles.com/private_files/lf30_gctc76jz.json',
                  width: 250,
                  height:250,
                ),
                  Text(
                    'Aun no has guardado ninguna receta',
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
            if (widget.likedRecipesIDs.isEmpty && widget.userId != widget.ownerId)
              Column(
                children: [
                  Lottie.network(
                  'https://assets6.lottiefiles.com/private_files/lf30_gctc76jz.json',
                  width: 250,
                  height:250,
                ),
                  Text(
                    'Aun no se ha guardado ninguna receta',
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
              if(widget.likedRecipesIDs.isNotEmpty)
            for (int i = 0; i < widget.likedRecipesIDs.length; i += 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ProfileRecipes(
                        idRecepieInDatabase: widget.likedRecipesIDs[i],
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
                      if (i + 1 < widget.likedRecipesIDs.length)
                        ProfileRecipes(
                          idRecepieInDatabase: widget.likedRecipesIDs[i + 1],
                          userImage: widget.profilePicData,
                          userName: widget.nameData,
                          userUsername: widget.usernameData,
                          screenWidth: screenSize.width,
                          userId: widget.userId,
                          userEmail: widget.emailData,
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
