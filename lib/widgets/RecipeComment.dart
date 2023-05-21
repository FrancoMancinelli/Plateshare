import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetails.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeComment extends StatefulWidget {
  
  const RecipeComment({
    Key? key,
  }) : super(key: key);

  @override
  _RecipeCommentState createState() => _RecipeCommentState();
}

class _RecipeCommentState extends State<RecipeComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.brownButtonsRecipe,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 130,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_profile_pic2.png?alt=media&token=61ad1f5c-b211-4068-b3da-feccba2f4b3e',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Administrador',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                    Text(
                      '@admin',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    //MÁXIMO 130 CARACTERES
                    child: Text(
                      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
