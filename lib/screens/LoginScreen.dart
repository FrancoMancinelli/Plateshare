import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../util/AppColors.dart';
import 'InicioScreen.dart';
import 'RecuperarScreen.dart';
import 'RegistroScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool isImageVisible = false;

 void validateAndAuthenticate() async {
  String usernameInput = _usernameController.text.toLowerCase();
  String passwordInput = _passwordController.text;
        setState(() {
          isImageVisible = true;
        });
  // Si todos los campos estan rellenos
  if (usernameInput.isNotEmpty && passwordInput.isNotEmpty) {
    // Compruebo si el usuario introducido existe, de ser así, encrypto la contraseña
    // y compruebo las credenciales
    Future<bool> userExist = checkIfUsernameExists(usernameInput);
    if (await userExist) {
      String databaseSalt = await getSaltByUsername(usernameInput);
      String hashedPassword = BCrypt.hashpw(passwordInput, databaseSalt);
      Future<bool> validCredentials =
          checkCredentials(usernameInput, hashedPassword);
      if (await validCredentials) {
        String emailData = await getEmailByUsername(usernameInput);
        String nameData = await getNameByUsername(usernameInput);
        String profilePicData = await getProfilePicByUsername(usernameInput);

        await Future.delayed(Duration(seconds: 3)); // Delay for 5 seconds

        final BuildContext _context = context;
        Future.microtask(() {
          Navigator.pushReplacement(
            _context,
            MaterialPageRoute(
              builder: (context) => InicioScreen(
                emailData: emailData,
                nameData: nameData,
                usernameData: usernameInput,
                profilePicData: profilePicData,
              ),
            ),
          );
        });
      } else {
        await Future.delayed(Duration(seconds: 3)); // Delay for 5 seconds

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Credenciales invalidas'),
            content: const Text('El usuario o contraseña son incorrectos'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isImageVisible = false;
                  });
                  Navigator.pop(context);
                },
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
      await Future.delayed(Duration(seconds: 3)); // Delay for 5 seconds

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Credenciales invalidas'),
          content: const Text('El usuario o contraseña son incorrectos'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isImageVisible = false;
                });
                Navigator.pop(context);
              },
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
              onPressed: () {
                setState(() {
                  isImageVisible = false;
                });
                Navigator.of(context).pop();
              },
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¡Bienvenido!',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                        Text(
                          'Comienza tu aventura aquí',
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: [
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
                        labelText: 'Username',
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
                    const SizedBox(height: 30.0),
                    Visibility(
  visible: !isImageVisible,
  child: SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: isImageVisible ? null : validateAndAuthenticate,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50.0),
        backgroundColor: const Color(0xFFFD9A00),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        'Iniciar sesión',
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

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                            height: 30,
                            indent: 5,
                            endIndent: 10,
                          ),
                        ),
                        Text('o',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                            height: 30,
                            indent: 10,
                            endIndent: 5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.network(
                        'https://i.imgur.com/h4jfgvd.png',
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Aun no tienes cuenta? ',
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
                                      builder: (context) =>
                                          const RegistroScreen()),
                                );
                              },
                              child: Text(
                                'Registrate',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecuperarScreen()),
                                );
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFFD9A00),
                                    fontFamily: 'Acme',
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
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
}
