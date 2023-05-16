import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class RecepieContainer extends StatefulWidget {
  final String idRecepieInDatabase;

  const RecepieContainer({
    Key? key,
    required this.idRecepieInDatabase,
  }) : super(key: key);

  @override
  _RecepieContainerState createState() => _RecepieContainerState();
}

class _RecepieContainerState extends State<RecepieContainer> {
  bool isFavorite = false;

  String title = "Default data information";
  String time = "0";
  String rate = "0.0";
  String image = "https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_recipeimage.jpg?alt=media&token=8400f8d3-7704-4a54-8151-da4053cf9102";

  @override
  void initState() {
    super.initState();
    fetchRecipeData();
  }

  Future<void> fetchRecipeData() async {
  final recipeData = await getRecipeFields(widget.idRecepieInDatabase);
  if (recipeData.isNotEmpty) {
    setState(() {
      if(recipeData[0].isNotEmpty) {
      image = recipeData[0];
      }
      title = recipeData[1];
      time = recipeData[2];
      rate = recipeData[3];
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Container(
        width: 220,
        height: 255,
        decoration: BoxDecoration(
          color: AppColors.brownRecepieColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //IMAGEN IMAGEN IMAGEN IMAGEN
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                width: 200,
                height: 160,
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Icon(Icons.star, color: Colors.white, size: 22),
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
                  child: Icon(Icons.access_time, color: Colors.white, size: 20),
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

            // NOMBRE DE RECETA | LIKE
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 5, 5),
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Container(
                      height: 50,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 1, 0, 0),
                        child: LikeButton(
                          bubblesColor: BubblesColor(
                              dotPrimaryColor:
                                  Color.fromARGB(255, 89, 182, 151),
                              dotSecondaryColor:
                                  Color.fromARGB(255, 76, 253, 129)),
                          circleColor: CircleColor(
                              end: Color.fromARGB(255, 89, 182, 151),
                              start: Color.fromARGB(255, 76, 253, 194)),
                          likeBuilder: (isFavorite) {
                            return Icon(
                              Icons.favorite,
                              color: isFavorite
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              size: 30,
                            );
                          },
                          onTap: onLikeButtonTapped,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }
}
