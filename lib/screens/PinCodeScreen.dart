import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';
import 'LoginScreen.dart';

class PinCodeScreen extends StatefulWidget {
  final String pin;
  final String username;
  final DateTime pinTime;
  final String password;

  const PinCodeScreen(
      {Key? key,
      required this.pin,
      required this.username,
      required this.pinTime,
      required this.password})
      : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  final TextEditingController digitController1 = TextEditingController();
  final TextEditingController digitController2 = TextEditingController();
  final TextEditingController digitController3 = TextEditingController();
  final TextEditingController digitController4 = TextEditingController();

  FocusNode digitFocusNode1 = FocusNode();
  FocusNode digitFocusNode2 = FocusNode();
  FocusNode digitFocusNode3 = FocusNode();
  FocusNode digitFocusNode4 = FocusNode();

  @override
  void dispose() {
    digitController1.dispose();
    digitController2.dispose();
    digitController3.dispose();
    digitController4.dispose();

    digitFocusNode1.dispose();
    digitFocusNode2.dispose();
    digitFocusNode3.dispose();
    digitFocusNode4.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    digitController1.addListener(() {
      if (digitController1.text.length == 1) {
        FocusScope.of(context).requestFocus(digitFocusNode2);
      }
    });

    digitController2.addListener(() {
      if (digitController2.text.length == 1) {
        FocusScope.of(context).requestFocus(digitFocusNode3);
      }
    });

    digitController3.addListener(() {
      if (digitController3.text.length == 1) {
        FocusScope.of(context).requestFocus(digitFocusNode4);
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo.png'),
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
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                      child: Text(
                        'Te hemos enviado un correo con un PIN de verificación para confirmar el cambio de contraseña. Por favor introdúcelo a continuación',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 20,
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
              Lottie.network(
                'https://assets6.lottiefiles.com/packages/lf20_e1y24wm2.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: digitController1,
                        focusNode: digitFocusNode1,
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
                            borderSide: const BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: digitController2,
                        focusNode: digitFocusNode2,
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
                            borderSide: const BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: digitController3,
                        focusNode: digitFocusNode3,
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
                            borderSide: const BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 1,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: digitController4,
                        focusNode: digitFocusNode4,
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
                            borderSide: const BorderSide(
                              color: AppColors.orangeColor,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          counterText: '',
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

  //Valida que el pin introducido sea el que se haya enviado por correo
  void validatePin() async {
    String d1 = digitController1.text;
    String d2 = digitController2.text;
    String d3 = digitController3.text;
    String d4 = digitController4.text;

    //Si los campos no estan vacios
    if (d1.isNotEmpty && d2.isNotEmpty && d3.isNotEmpty && d4.isNotEmpty) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(widget.pinTime);
      //Comprueba que el PIN no haya caducado (30 segundos)
      if (difference.inSeconds < 30) {
        String pinCompletoInput = d1 + d2 + d3 + d4;
        //Si el PIN es valido...
        if (widget.pin == pinCompletoInput) {
          updateUserPasswordByUsername(widget.username, widget.password);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contraseña actualizada con éxito'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
