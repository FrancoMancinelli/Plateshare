import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';
import 'LoginScreen.dart';

class PinCodeScreen extends StatefulWidget {
  final String pin;
  final String username;
  final DateTime pinTime;
  final String password;

  const PinCodeScreen({Key? key, required this.pin, required this.username, required this.pinTime, required this.password}) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final TextEditingController _1DigitController = TextEditingController();
  final TextEditingController _2DigitController = TextEditingController();
  final TextEditingController _3DigitController = TextEditingController();
  final TextEditingController _4DigitController = TextEditingController();

  FocusNode _1DigitFocusNode = FocusNode();
  FocusNode _2DigitFocusNode = FocusNode();
  FocusNode _3DigitFocusNode = FocusNode();
  FocusNode _4DigitFocusNode = FocusNode();

  @override
  void dispose() {
    _1DigitController.dispose();
    _2DigitController.dispose();
    _3DigitController.dispose();
    _4DigitController.dispose();

    _1DigitFocusNode.dispose();
    _2DigitFocusNode.dispose();
    _3DigitFocusNode.dispose();
    _4DigitFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _1DigitController.addListener(() {
      if (_1DigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_2DigitFocusNode);
      }
    });

    _2DigitController.addListener(() {
      if (_2DigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_3DigitFocusNode);
      }
    });

    _3DigitController.addListener(() {
      if (_3DigitController.text.length == 1) {
        FocusScope.of(context).requestFocus(_4DigitFocusNode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://i.imgur.com/pbBleS1.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Verificación',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
                      child: Text(
                        'Te hemos enviado un correo con un pin de verificación para confirmar el cambio de contraseña. Por favor introdúcelo a continuación',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Acme',
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _1DigitController,
                        focusNode: _1DigitFocusNode,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: 'Acme',
                          ),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '', // Hides the character counter
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _2DigitController,
                        focusNode: _2DigitFocusNode,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: 'Acme',
                          ),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '', // Hides the character counter
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _3DigitController,
                        focusNode: _3DigitFocusNode,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: 'Acme',
                          ),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '', // Hides the character counter
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _4DigitController,
                        focusNode: _4DigitFocusNode,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontFamily: 'Acme',
                          ),
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '', // Hides the character counter
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          validatePin();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50.0),
                          backgroundColor: AppColors.orangeColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'Verificar',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validatePin() async {
  String d1 = _1DigitController.text;
  String d2 = _2DigitController.text;
  String d3 = _3DigitController.text;
  String d4 = _4DigitController.text;

  if (d1.isNotEmpty && d2.isNotEmpty && d3.isNotEmpty && d4.isNotEmpty) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(widget.pinTime);
    if (difference.inMinutes < 2) {
      String pinCompletoInput = d1+d2+d3+d4;
      if(widget.pin == pinCompletoInput) {

        updateUserPasswordByUsername(widget.username, widget.password);
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Contraseña actualizada con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
      } else {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('PIN Incorrecto'),
            content: const Text('El pin introducido es incorrecto'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('PIN Caducado'),
            content: const Text('El tiempo de uso del PIN ha caducado'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('PIN Incompleto'),
            content: const Text('Rellena todos los campos para continuar'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
  }
}

}


