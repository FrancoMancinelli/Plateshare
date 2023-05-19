import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetails.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class InstructionsContainer extends StatefulWidget {

  const InstructionsContainer({
    Key? key,
  }) : super(key: key);

  @override
  _InstructionsContainerState createState() => _InstructionsContainerState();
}

class _InstructionsContainerState extends State<InstructionsContainer> {

  List<String> steps = [
        '1.- Poner a precalentar el horno',
    '2.- Poner a precalentar el horno',
    '3.- Poner a precalentar el horno',
    '4.- Poner a precalentar el horno',
    '5.- Poner a precalentar el horno',
    '6.- Poner a precalentar el horno',
    '7.- Poner a precalentar el horno',
    '8.- Poner a precalentar el horno',
    '9.- Poner a precalentar el horno',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps.map((ingredient) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text(
                  ingredient,
                  style: TextStyle(
                    color: AppColors.brownTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        //
      ],
    );
  }


}
