import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecepieContainer.dart';

class RecepiesPage extends StatelessWidget {
  const RecepiesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 2,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Text(
                  'Economicas',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  "En menos de 15'",
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  "Postres",
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                  RecepieContainer(),
                ],
              ),
            ),
          ),          
        ],
      ),
    );
  }
}
