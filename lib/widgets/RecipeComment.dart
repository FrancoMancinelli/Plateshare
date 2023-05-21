import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetails.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeComment extends StatefulWidget {
  final String commentOwnerID;
  final String commentText;

  const RecipeComment({
    Key? key,
    required this.commentOwnerID,
    required this.commentText,
  }) : super(key: key);

  @override
  _RecipeCommentState createState() => _RecipeCommentState();
}

class _RecipeCommentState extends State<RecipeComment> {
  String ownerImage = 'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_recipeimage.jpg?alt=media&token=8400f8d3-7704-4a54-8151-da4053cf9102';
  String ownerName = 'A';
  String ownerUsername = 'A';

  @override
  void initState() {
    super.initState();
    fetchCommentData();
  }

  Future<void> fetchCommentData() async {
  final image = await getUserImageByDocumentId(widget.commentOwnerID);
  final name = await getUserNameByDocumentId(widget.commentOwnerID);
  final username = await getUserUsernameByDocumentId(widget.commentOwnerID);


  
    setState(() {
      ownerImage = image as String;
      ownerName = name as String;
      ownerUsername = username as String;
    }
      );
  
}

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
                      ownerImage,
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
                      ownerName,
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                    Text(
                      '@$ownerUsername',
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
                      widget.commentText,
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
