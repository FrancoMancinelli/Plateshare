import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormStepThree extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const RecipeFormStepThree({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _RecipeFormStepThreeState createState() => _RecipeFormStepThreeState();
}

class _RecipeFormStepThreeState extends State<RecipeFormStepThree> {
@override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: screenSize.width,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmación'),
                            content: const Text(
                                '¿Estás seguro que deseas abandonar el proceso? Si abandonas, el progreso no se guardará'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                            
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InicioScreen(
                                        emailData: widget.emailData,
                                        nameData: widget.nameData,
                                        profilePicData: widget.profilePicData,
                                        usernameData: widget.usernameData,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Abandonar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sube una receta',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 80,
              color: AppColors.recomendationColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.lightbulb_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Por favor, brinde una descripción detallada de los pasos a seguir en la elaboración de la receta para aquellas personas que tienen menos experiencia en la cocina.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.brownTextColor,
                            fontSize: 15,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
  
