import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';

class RecepiesPage extends StatelessWidget {
  const RecepiesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
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
                padding: const EdgeInsets.only(left: 10),
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
                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
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
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: 215,
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.brownRecepieColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
