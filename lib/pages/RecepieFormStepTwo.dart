import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormStepTwo extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const RecipeFormStepTwo({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);
  @override
  _RecipeFormStepTwoState createState() => _RecipeFormStepTwoState();
}

class _RecipeFormStepTwoState extends State<RecipeFormStepTwo> {
  final TextEditingController _tituloController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [Container(
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
                                  Navigator.pop(context); // Close the dialog
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
                        Icons.arrow_back_ios,
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
        ),],);
  }
}
