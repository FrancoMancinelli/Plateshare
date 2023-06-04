import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';

import '../util/AppColors.dart';

class AjustesScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String fechaData;

  const AjustesScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData, required this.fechaData,
  }) : super(key: key);

  @override
  _AjustesScreenState createState() => _AjustesScreenState();
}

var screenSizeAjustesScreen;



class _AjustesScreenState extends State<AjustesScreen> {

TextEditingController _nombreController = TextEditingController();
TextEditingController _userController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _fechaController = TextEditingController();
TextEditingController _idiomaController = TextEditingController();
TextEditingController _versionController = TextEditingController();


    @override
  void initState() {
    super.initState();
    _nombreController.text = widget.nameData;
    _userController.text = widget.usernameData;
    _emailController.text = widget.emailData;
_passwordController.text = '***********';
_fechaController.text = widget.fechaData;
_idiomaController.text = 'Español';
_versionController.text = 'V0.1.4';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeAjustesScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.primaryColor,
              height: 50,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Ajustes',
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 24,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: AppColors.whiteColor,
                      size: 22,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.accentColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              'Información del perfil',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: AppColors.brownTextColor,
                                  fontSize: 19,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 2, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(widget.profilePicData),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppColors.brownInfoRecipe,
                                  size: 25,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.person),
                                  SizedBox(width: 10),
                                  Text('Nombre: '),
                                  Expanded(
                                    child: TextField(
                                      controller: _nombreController,
                                      decoration: InputDecoration(
                                        hintText: 'Nombre',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.language_outlined),
                                  SizedBox(width: 10),
                                  Text('Usuario: '),
                                  Expanded(
                                    child: TextField(
                                      controller: _userController,
                                      decoration: InputDecoration(
                                        hintText: 'Usuario',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.email_outlined),
                                  SizedBox(width: 10),
                                  Text('Email: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.lock),
                                  SizedBox(width: 10),
                                  Text('Contraseña: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        hintText: 'Contraseña actual',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined),
                                  SizedBox(width: 10),
                                  Text('Miembro desde: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _fechaController,
                                      decoration: InputDecoration(
                                        hintText: 'Fecha creación',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orangeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Actualizar datos',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                            child: Text(
                              'Información general',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: AppColors.brownTextColor,
                                  fontSize: 19,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.spellcheck_rounded),
                                  SizedBox(width: 10),
                                  Text('Idioma: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _idiomaController,
                                      decoration: InputDecoration(
                                        hintText: 'Idioma',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 4),
                              padding: EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.settings_backup_restore_outlined),
                                  SizedBox(width: 10),
                                  Text('Versión: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _versionController,
                                      decoration: InputDecoration(
                                        hintText: 'Version',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //END
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
