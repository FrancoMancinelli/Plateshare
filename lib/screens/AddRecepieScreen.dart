import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/pages/RecepieFormStepOne.dart';
import 'package:plateshare/pages/RecepieFormStepTwo.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class AddRecepieScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const AddRecepieScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _AddRecepieScreenState createState() => _AddRecepieScreenState();
}


class _AddRecepieScreenState extends State<AddRecepieScreen> {
    int currentStep = 1;


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    Widget currentFormStep;
    if (currentStep == 1) {
      currentFormStep = RecipeFormStepOne(
        emailData: widget.emailData,
        nameData: widget.nameData,
        profilePicData: widget.profilePicData,
        usernameData: widget.usernameData,
      );
    } else {
      currentFormStep = RecipeFormStepTwo(
        emailData: widget.emailData,
        nameData: widget.nameData,
        profilePicData: widget.profilePicData,
        usernameData: widget.usernameData,
      );
    }
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: AppColors.accentColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                currentFormStep,
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Paso $currentStep de 3',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: Color(0xFF80684C),
                                  fontSize: 15,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (currentStep < 3) {
                                    currentStep++;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                'Continuar',
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
