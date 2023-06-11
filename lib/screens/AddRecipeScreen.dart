import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/util/AppColors.dart';

class AddRecipeScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const AddRecipeScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: AppColors.primaryColor,
              child: SafeArea(
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                    color: AppColors.accentColor,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: currentStep != 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 10, 0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (currentStep > 1) {
                                              currentStep--;
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors
                                              .whiteColor, // Customize the color as needed
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: Text(
                                          'Volver',
                                          style: GoogleFonts.acme(
                                            textStyle: const TextStyle(
                                              color: AppColors.brownTextColor,
                                              fontSize: 16,
                                              fontFamily: 'Acme',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 20, 0),
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
                                          borderRadius:
                                              BorderRadius.circular(100),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
