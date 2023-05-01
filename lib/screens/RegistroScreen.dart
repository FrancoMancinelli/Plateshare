import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  String _emailErrorText = '';
  String _nameErrorText = '';
  String _usernameErrorText = '';
  String _passwordErrorText = '';
  String _repeatPasswordErrorText = '';

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
            SizedBox(
              height: 15,
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: Icon(
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
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.black),
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
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon: Icon(Icons.contact_emergency_outlined,
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
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon:
                          Icon(Icons.person_outline, color: Colors.black),
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
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
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
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.black),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 55.0),
                        backgroundColor: Color(0xFFFD9A00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                                builder: (context) => LoginScreen()),
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
    );
  }
}
