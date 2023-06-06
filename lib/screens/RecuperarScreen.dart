import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';
import 'LoginScreen.dart';

class RecuperarScreen extends StatefulWidget {
  const RecuperarScreen({Key? key}) : super(key: key);

  @override
  _RecuperarScreenState createState() => _RecuperarScreenState();
}

class _RecuperarScreenState extends State<RecuperarScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

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
                          borderSide: BorderSide(
                              color: AppColors.orangeColor, width: 2),
                        ),
                        labelText: 'Usuario',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                          borderSide: BorderSide(
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
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _repeatPasswordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(
                              color: AppColors.orangeColor, width: 2),
                        ),
                        labelText: 'Repite Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: validateFields,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50.0),
                          backgroundColor: const Color(0xFFFD9A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'Confirmar',
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
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
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

  Future<void> validateFields() async {
    String usernameInput = _usernameController.text.toLowerCase();
    String passwordInput = _passwordController.text;
    String repeatPasswordInput = _repeatPasswordController.text;

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
          if (passwordInput.length >= 8) {
            //Hashea la contraseña y la actualiza, luego vuelve al Login
            String salt = await getSaltByUsername(usernameInput);
            String hashedPassword = BCrypt.hashpw(passwordInput, salt);
            updateUserPasswordByUsername(usernameInput, hashedPassword);

            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Contraseña insegura'),
                  content: const Text(
                      'La contraseña debe tener al menos 8 caracteres'),
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
        }
      } else {
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
    }
  }
}
