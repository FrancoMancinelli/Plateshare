import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetailsScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeComment extends StatefulWidget {
  final String commentOwnerID;
  final String commentText;
  final String commentDate;

  const RecipeComment({
    Key? key,
    required this.commentOwnerID,
    required this.commentText,
    required this.commentDate,
  }) : super(key: key);

  @override
  _RecipeCommentState createState() => _RecipeCommentState();
}

class _RecipeCommentState extends State<RecipeComment> {
  String ownerImage =
      'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_recipeimage.jpg?alt=media&token=8400f8d3-7704-4a54-8151-da4053cf9102';
  String ownerName = 'A';
  String ownerUsername = 'A';
  String timePassed = '';

  @override
  void initState() {
    super.initState();
    fetchCommentData();
  }

  @override
  void didUpdateWidget(RecipeComment oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchCommentData();
  }

  Future<void> fetchCommentData() async {
    final image = await getUserImageByDocumentId(widget.commentOwnerID);
    final name = await getUserNameByDocumentId(widget.commentOwnerID);
    final username = await getUserUsernameByDocumentId(widget.commentOwnerID);

    final commentDateTime =
        DateFormat('dd/MM/yyyy HH:mm:ss').parse(widget.commentDate);
    final timeDifference = DateTime.now().difference(commentDateTime);

    setState(() {
      ownerImage = image as String;
      ownerName = name as String;
      ownerUsername = username as String;
      timePassed = formatTimeDifference(timeDifference);
    });
  }

  String formatTimeDifference(Duration difference) {
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} segundos';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutos';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} horas';
    } else {
      return '${difference.inDays} dias';
    }
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
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.blackColor,
                        width: 1.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 17.5,
                      backgroundImage: NetworkImage(ownerImage),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ownerName,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                      Text(
                        '@$ownerUsername',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 11),
                  child: Text(
                    'Hace $timePassed',
                    style: GoogleFonts.acme(
                      textStyle: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                        fontFamily: 'Acme',
                      ),
                    ),
                  ),
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
                          color: AppColors.whiteColor,
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
