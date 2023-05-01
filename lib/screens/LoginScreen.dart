import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final String _usernameErrorText = '';
  final String _passwordErrorText = '';

  

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      labelText: 'Username',
                      errorText: _usernameErrorText.isEmpty
                          ? null
                          : _usernameErrorText,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
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
                      contentPadding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                    ),
                      obscureText: true,
                  ),
                  const SizedBox(height: 50.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InicioScreen()),
                        );},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60.0),
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
                          style: TextStyle(fontSize: 15, color: Colors.white)),
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
                                fontSize:20,
                                color: Colors.white,
                                fontFamily: 'Acme',
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistroScreen()),
                      );},
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
                            onTap: () {Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RecuperarScreen()),
                      );},
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
    );
  }
}
