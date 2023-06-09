import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:plateshare/screens/LoginScreen.dart';
import 'package:plateshare/screens/RecipeDetailsScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';

class InstructionsContainer extends StatefulWidget {
final List<String> recipeSteps;

  const InstructionsContainer({
    Key? key, required this.recipeSteps,
  }) : super(key: key);

  @override
  _InstructionsContainerState createState() => _InstructionsContainerState();
}

class _InstructionsContainerState extends State<InstructionsContainer> {

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.recipeSteps.map((step) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Text(
                      step,
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
        ),
      ),
    );
  }


}
