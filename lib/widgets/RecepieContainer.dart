import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/util/AppColors.dart';

class RecepieContainer extends StatefulWidget {
  const RecepieContainer({
    Key? key,
  }) : super(key: key);

  @override
  _RecepieContainerState createState() => _RecepieContainerState();
}

class _RecepieContainerState extends State<RecepieContainer> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'https://i.imgur.com/ZLbmHME.png',
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
                  '4.5',
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
                  '30 mins',
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
                      'Canelones de navidad y mucho más',
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
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorite ? AppColors.primaryColor : AppColors.brownRecepieColor,
                        size: 28,
                      ),
                      onPressed: toggleFavorite,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
