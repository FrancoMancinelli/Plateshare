import 'dart:convert';
import 'dart:math';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';
import 'LoginScreen.dart';
import 'PinCodeScreen.dart';

class RecuperarScreen extends StatefulWidget {
  const RecuperarScreen({Key? key}) : super(key: key);

  @override
  _RecuperarScreenState createState() => _RecuperarScreenState();
}

class _RecuperarScreenState extends State<RecuperarScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool isImageVisible = false;

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
                      if (!isImageVisible) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      }
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
                          'Recuperar Contraseña',
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
                        'Enviaremos un correo electrónico para confirmar el cambio de contraseña',
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
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              color: AppColors.orangeColor, width: 2),
                        ),
                        labelText: 'Usuario',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              color: AppColors.orangeColor, width: 2),
                        ),
                        labelText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      obscureText: _obscureText,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _password2Controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: const BorderSide(
                              color: AppColors.orangeColor, width: 2),
                        ),
                        labelText: 'Repite Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                          child: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                          ),
                        ),
                      ),
                      obscureText: _obscureText2,
                    ),
                    const SizedBox(height: 40.0),
                    Visibility(
                      visible: !isImageVisible,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: validateFields,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50.0),
                            backgroundColor: AppColors.orangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'Continuar',
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
                    ),
                    if (isImageVisible)
                      Lottie.network(
                        'https://assets1.lottiefiles.com/packages/lf20_zuyjlvgp.json',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isImageVisible) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50.0),
                          backgroundColor: const Color(0xFFF9EDDE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'Cancelar',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 28,
                              color: Colors.black,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

  // Valida que los valores introducidos sean validos y correctos
  Future<void> validateFields() async {
    String usernameInput = _usernameController.text.toLowerCase();
    String passwordInput = _passwordController.text;
    String repeatPasswordInput = _password2Controller.text;
    setState(() {
      isImageVisible = true;
    });
    // Si estan todos los campos rellenos
    if (usernameInput.isNotEmpty &&
        passwordInput.isNotEmpty &&
        repeatPasswordInput.isNotEmpty) {
      //Compruebo que el usuario exista
      Future<bool> userExist = checkIfUsernameExists(_usernameController.text);
      if (await userExist) {
        //Comprueba que las nuevas contraseñas sean iguales
        if (passwordInput == repeatPasswordInput) {
          //Comprueba que la contraseña mida al menos 8 caracteres
          if (passwordInput.length >= 8 && passwordInput.length <= 24) {
            String pinCode = generatePin();
            String userId = await getDocumentIdByUsername(usernameInput);

            DateTime pinTime = DateTime.now();

            String salt = await getSaltByUsername(usernameInput);
            String hashedPassword = BCrypt.hashpw(passwordInput, salt);

            String userEmail = await getEmailByUsername(usernameInput);

            await enviarEmail(
                email: userEmail, pinCode: pinCode, username: usernameInput);

            await Future.delayed(const Duration(seconds: 3));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PinCodeScreen(
                      username: usernameInput,
                      pin: pinCode,
                      pinTime: pinTime,
                      password: hashedPassword)),
            );
          } else {
            await Future.delayed(const Duration(seconds: 3));

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Contraseña insegura'),
                  content: const Text(
                      'La contraseña debe tener al menos 8 caracteres y máximo 24'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            setState(() {
              isImageVisible = false;
            });
          }
        } else {
          await Future.delayed(const Duration(seconds: 3));

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Contraseña invalida'),
                content: const Text('Las contraseñas no coinciden'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
          setState(() {
            isImageVisible = false;
          });
        }
      } else {
        await Future.delayed(const Duration(seconds: 3));

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Usuario invalido'),
            content: const Text('El usuario no existe'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK.'),
              ),
            ],
          ),
        );
        setState(() {
          isImageVisible = false;
        });
        return;
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Campos incompletos'),
            content: const Text('Rellena todos los campos'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        isImageVisible = false;
      });
    }
  }

  // Envia un Email al correo del usuario indicando el PIN para cambiar su contraseña
  Future enviarEmail({email, pinCode, username}) async {
    var serviceId = 'service_df6jida';
    var templateId = 'template_2o26bsr';
    var userId = 'J0XTNBhNp5LcSKLga';

    var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    try {
    await http.post(url,
          headers: {
            'origin': '<http://localhost>',
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'username': username,
              'to_email': email,
              'pin_code': pinCode,
            }
          }));
    } catch (error) {
      //
    }
  }

  // Genera un PIN aleatorio de 4 números
  String generatePin() {
    Random random = Random();
    String result = '';

    for (int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(10);
      result += randomNumber.toString();
    }

    return result;
  }
}
