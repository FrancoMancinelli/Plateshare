import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';

class SettingsScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String fechaData;

  const SettingsScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.fechaData,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

dynamic screenSizeAjustesScreen;

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _idiomaController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  String currentUsername = '';
  String currentName = '';
  String currentImage = '';
  String imageUrl = '';
  XFile? imageRecipe = XFile('');

  // Muestra un mensaje en la parte inferior de la pantalla según el valor indicado
  void showRequired(int index) {
    switch (index) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El nombre ha sido actualizado con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El usuario ha sido actualizado con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        break;

      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'El usuario indicado ya esta en uso, por favor elige otro'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 4:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Rellena todos los campos para actualizar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 5:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'El nombre de usuario solo puede contener letras, números, y los siguientes caracters: ( _ - . ) y no puede contener espacios ni terminar con un punto'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 6:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Imagen actualizada con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        break;
    }
  }

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
    currentUsername = widget.usernameData;
    currentName = widget.nameData;
    currentImage = widget.profilePicData;
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
                    icon: const Icon(
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
                    icon: const Icon(
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
                            nameData: currentName,
                            profilePicData: currentImage,
                            usernameData: currentUsername,
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
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
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
                                backgroundImage: NetworkImage(currentImage),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: AppColors.brownInfoRecipe,
                                  size: 25,
                                ),
                                onPressed: () async {
                                  String userId = await getDocumentIdByUsername(
                                      currentUsername);
                                  ImagePicker imagePicker = ImagePicker();
                                  imageRecipe = await imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  if (imageRecipe != null) {
                                    String uniqueFileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                        referenceRoot.child('profiles');
                                    Reference referenceImageToUpload =
                                        referenceDirImages
                                            .child(uniqueFileName);

                                    try {
                                      await referenceImageToUpload
                                          .putFile(File(imageRecipe!.path));
                                      imageUrl = await referenceImageToUpload
                                          .getDownloadURL();
                                      currentImage = imageUrl;

                                      setState(() {
                                        currentImage = imageUrl;
                                      });

                                      updateProfilePic(userId, currentImage);
                                      showRequired(6);
                                    } catch (error) {
                                     //
                                    }
                                  }
                                },
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
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.person),
                                  const SizedBox(width: 10),
                                  const Text('Nombre: '),
                                  Expanded(
                                    child: TextField(
                                      controller: _nombreController,
                                      decoration: const InputDecoration(
                                        hintText: 'Nombre',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.greyAccentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.language_outlined),
                                  const SizedBox(width: 10),
                                  const Text('Usuario: '),
                                  Expanded(
                                    child: TextField(
                                      controller: _userController,
                                      decoration: const InputDecoration(
                                        hintText: 'Usuario',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.email_outlined),
                                  const SizedBox(width: 10),
                                  const Text('Email: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Email',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.lock),
                                  const SizedBox(width: 10),
                                  const Text('Contraseña: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                        hintText: 'Contraseña actual',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_month_outlined),
                                  const SizedBox(width: 10),
                                  const Text('Miembro desde: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _fechaController,
                                      decoration: const InputDecoration(
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
                          onPressed: () async {
                            String newNameText = _nombreController.text;
                            String newUserText =
                                _userController.text.toLowerCase();
                            bool available = false;

                            if (newNameText.isNotEmpty &&
                                newUserText.isNotEmpty) {
                              String userId = await getDocumentIdByUsername(
                                  currentUsername);

                              if (newNameText != currentName) {
                                updateUserName(userId, newNameText);
                                currentName = newNameText;
                                showRequired(1);
                              }

                              if (newUserText != currentUsername) {
                                if (isValidUsername(newUserText)) {
                                  available =
                                      !await checkIfUsernameExists(newUserText);
                                  if (available == true) {
                                    updateUserUsername(userId, newUserText);
                                    currentUsername = newUserText;
                                    showRequired(2);
                                  } else {
                                    showRequired(3);
                                  }
                                } else {
                                  showRequired(5);
                                }
                              }
                            } else {
                              showRequired(4);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
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
                            padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
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
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.spellcheck_rounded),
                                  const SizedBox(width: 10),
                                  const Text('Idioma: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _idiomaController,
                                      decoration: const InputDecoration(
                                        hintText: 'Idioma',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              padding: const EdgeInsets.fromLTRB(10, 1, 0, 1),
                              decoration: BoxDecoration(
                                color: AppColors.desabledField,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                      Icons.settings_backup_restore_outlined),
                                  const SizedBox(width: 10),
                                  const Text('Versión: '),
                                  Expanded(
                                    child: TextField(
                                      enabled: false,
                                      controller: _versionController,
                                      decoration: const InputDecoration(
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

  // Método que comprueba que el usuario nuevo introducido sea valido
  bool isValidUsername(String username) {
    // Verificar si no hay espacios en blanco
    if (username.contains(' ')) {
      return false;
    }

    // Verificar si solo contiene los caracteres permitidos
    final validChars = RegExp(r'^[a-zA-Z0-9_\-]+(\.[a-zA-Z0-9_\-]+)*$');
    if (!validChars.hasMatch(username)) {
      return false;
    }

    return true;
  }
}
