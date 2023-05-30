import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:bcrypt/bcrypt.dart';

import 'LoginScreen.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({Key? key}) : super(key: key);

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText2 = true;

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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '¡Registrate Gratis!',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rellena los campos a continuación',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Correo',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Nombre',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon: const Icon(Icons.contact_emergency_outlined,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        labelText: 'Usuario',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.black),
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
                    const SizedBox(height: 15.0),
                    TextField(
                    controller: _repeatPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Repite Contraseña',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.black),
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
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: validateRegiser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45.0),
                          backgroundColor: const Color(0xFFFD9A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'Registrar',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tienes una cuenta? ',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Text(
                            'Inicia sesión',
                            style: GoogleFonts.acme(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFFFD9A00),
                                fontFamily: 'Acme',
                                decoration: TextDecoration.underline,
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
    );
  }

  Future<void> validateRegiser() async {
    String emailInput = _emailController.text.toLowerCase();
    String nameInput = _nameController.text;
    String usernameInput = _usernameController.text.toLowerCase();
    String passwordInput = _passwordController.text;
    String repeatPasswordInput = _repeatPasswordController.text;

    //Compruebo que esten todos los campos rellenos
    if (emailInput.isNotEmpty &&
        nameInput.isNotEmpty &&
        usernameInput.isNotEmpty &&
        passwordInput.isNotEmpty &&
        repeatPasswordInput.isNotEmpty) {
      //Compruebo que las contraseñas coincidan
      if (passwordInput == repeatPasswordInput) {
        //Compruebo que la contraseña tenga al menos 8 cracteres
        if(passwordInput.length >= 8) {
        //Compruebo que el username no este en uso
        Future<bool> userExist = checkIfUsernameExists(usernameInput);
        if (!await userExist) {
          //Compruebo que el correo sea valido
          if (Validator.isEmail(emailInput)) {
            //Compruebo que el correo no este en uso
            Future<bool> emailExist = checkIfEmailExists(emailInput);
            if (!await emailExist) {
              //Si es todo valido hasheo la contraseña y añado al usuario. Luego vuelvo al Login
              String salt = BCrypt.gensalt();
              String hashedPassword = BCrypt.hashpw(passwordInput, salt);
              addNewUser(emailInput, nameInput, usernameInput, hashedPassword, salt);
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              });
            } else {
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Correo invalido'),
                    content: const Text('El correo ya esta en uso'),
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
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Correo invalido'),
                  content: const Text('Introduce un correo valido'),
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
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Usuario invalido'),
                content: const Text('El nombre de usuario ya esta en uso'),
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
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Contraseña insegura'),
            content: const Text('La contraseña debe tener al menos 8 caracteres'),
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
            title: const Text('Registro invalido'),
            content: const Text('Rellena todos los campos.'),
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

class Validator {
  static bool isEmail(String value) {
    final RegExp regex =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    return regex.hasMatch(value);
  }
}
