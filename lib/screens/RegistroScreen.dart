import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/services/firebase_service.dart';

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
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  String _emailErrorText = '';
  String _nameErrorText = '';
  String _usernameErrorText = '';
  String _passwordErrorText = '';
  String _repeatPasswordErrorText = '';

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
  body: SingleChildScrollView(
    child: Container(
      width: screenSize.width,
      height: screenSize.height,
      decoration: const BoxDecoration(
        color: Color(0xFF056C49),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: const AlignmentDirectional(-0.2, 0),
              child: Image.network(
                'https://imgur.com/ziSeq5r.png',
                width: 171,
                height: 107,
                fit: BoxFit.scaleDown,
              ),
            ),
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
                    Icons.arrow_back_ios,
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
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Correo',
                      errorText:
                          _emailErrorText.isEmpty ? null : _emailErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Nombre',
                      errorText: _nameErrorText.isEmpty ? null : _nameErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon: const Icon(Icons.contact_emergency_outlined,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Usuario',
                      errorText: _usernameErrorText.isEmpty
                          ? null
                          : _usernameErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Contraseña',
                      errorText: _passwordErrorText.isEmpty
                          ? null
                          : _passwordErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.black),
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
                      labelText: 'Repite Contraseña',
                      errorText: _repeatPasswordErrorText.isEmpty
                          ? null
                          : _repeatPasswordErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.black),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: validateRegiser,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 55.0),
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
                    height: 20,
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
            const SizedBox(height: 30.0),
            Expanded(
              child: Image.network(
                'https://i.imgur.com/VhMzz4T.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
  ),
    );
  }

  Future<void> validateRegiser() async {
    String emailInput = _emailController.text;
    String nameInput = _nameController.text;
    String usernameInput = _usernameController.text;
    String passwordInput = _passwordController.text;
    String repeatPasswordInput = _repeatPasswordController.text;

    if (emailInput.isEmpty) {
      setState(() {
        _emailErrorText = 'Introduzca el correo';
      });
    } else {
      setState(() {
        _emailErrorText = '';
      });
    }
    if (nameInput.isEmpty) {
      setState(() {
        _nameErrorText = 'Introduzca su nombre';
      });
    } else {
      setState(() {
        _nameErrorText = '';
      });
    }

    if (usernameInput.isEmpty) {
      setState(() {
        _usernameErrorText = 'Introduzca el username';
      });
    } else {
      setState(() {
        _usernameErrorText = '';
      });
    }

    if (passwordInput.isEmpty) {
      setState(() {
        _passwordErrorText = 'Introduzca la contraseña';
      });
    } else {
      setState(() {
        _passwordErrorText = '';
      });
    }

    if (repeatPasswordInput.isEmpty) {
      setState(() {
        _repeatPasswordErrorText = 'Intoduzca la contraseña nuevamente';
      });
    } else {
      setState(() {
        _repeatPasswordErrorText = '';
      });
    }
    //Compruebo que esten todos los campos rellenos
    if (emailInput.isNotEmpty && nameInput.isNotEmpty && usernameInput.isNotEmpty && passwordInput.isNotEmpty && repeatPasswordInput.isNotEmpty) {
      //Compruebo que las contraseñas coincidan
      if (passwordInput == repeatPasswordInput) {
        //Compruebo que el username no este en uso
        Future<bool> userExist = checkIfUsernameExists(usernameInput);
        if (!await userExist) {
          //Compruebo que el correo sea valido
          if (Validator.isEmail(emailInput)) {
            //Compruebo que el correo no este en uso
            Future<bool> emailExist = checkIfEmailExists(emailInput);
            if (!await emailExist) {
              //Si es todo valido añado al usuario y vuelvo al Login
              addNewUser(emailInput, nameInput, usernameInput, passwordInput);
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
          }else{
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
        }else{
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
      }else{
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
    }else{
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
