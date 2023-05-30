import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenTwo.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormScreenOne extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const RecipeFormScreenOne({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _RecipeFormScreenOneState createState() => _RecipeFormScreenOneState();
}

class _RecipeFormScreenOneState extends State<RecipeFormScreenOne> {
  List<List<String>> buttonTexts = [
    ['Vegano', 'Gluten free', 'Sin lactosa', 'Vegetariano'],
    ['Ocasional', 'Infantil', 'Rápido', 'Salsas'],
    ['Bebidas', 'Picante', 'Económica', 'Agridulce'],
    ['Saludable', 'Proteico', 'Postre', 'Fríos'],
    ['Caliente', 'Italiana', 'Asiática', 'Mexicana'],
    ['Festiva', 'Tradicional', 'Snack', 'Fácil'],
  ];

  List<List<bool>> buttonStates = List.generate(
    6,
    (rowIndex) => List.generate(4, (colIndex) => false),
  );

  List<String> getSelectedButtonValues() {
  List<String> selectedValues = [];

  for (int rowIndex = 0; rowIndex < buttonStates.length; rowIndex++) {
    for (int colIndex = 0; colIndex < buttonStates[rowIndex].length; colIndex++) {
      if (buttonStates[rowIndex][colIndex]) {
        String value = buttonTexts[rowIndex][colIndex];
        selectedValues.add(value);
      }
    }
  }

  return selectedValues;
}

  void updateButtonState(int rowIndex, int colIndex) {
    setState(() {
      buttonStates[rowIndex][colIndex] = !buttonStates[rowIndex][colIndex];
      int selectedCount = 0;
      for (var i = 0; i < buttonStates.length; i++) {
        for (var j = 0; j < buttonStates[i].length; j++) {
          if (buttonStates[i][j]) {
            selectedCount++;
          }
        }
      }
      if (selectedCount > 5) {
        // Disable buttons if more than 5 are selected
        buttonStates[rowIndex][colIndex] = false;
      }
    });
  }

  void showRequired(int index) {
    switch (index) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Indica el titulo de la receta para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Indica al menos una categoría a la que pertenzca tu receta para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
    }
  }

  void _updateSliderValue(double newValue) {
    setState(() {
      _sliderValue = newValue;
    });
  }


  final TextEditingController _tituloController = TextEditingController();
  double _sliderValue = 45.0;
  XFile? imageRecipe = XFile('');

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: AppColors.primaryColor,
              child: SafeArea(
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                    color: AppColors.accentColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        width: screenSize.width,
                        color: AppColors.primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Confirmación'),
                                          content: const Text(
                                              '¿Estás seguro que deseas abandonar el proceso? Si abandonas, el progreso no se guardará'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context); // Close the dialog
                                              },
                                              child: const Text(
                                                'Continuar',
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // set all selection states to false
                                                setState(() {
                                                  buttonStates = List.generate(
                                                      6,
                                                      (index) => List.generate(
                                                          4, (index) => false));
                                                });
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InicioScreen(
                                                      emailData:
                                                          widget.emailData,
                                                      nameData: widget.nameData,
                                                      profilePicData:
                                                          widget.profilePicData,
                                                      usernameData:
                                                          widget.usernameData,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Abandonar',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Sube una receta',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.acme(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontFamily: 'Acme',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Imagen',
                                            style: GoogleFonts.acme(
                                              textStyle: const TextStyle(
                                                color: AppColors.brownTextColor,
                                                fontSize: 16,
                                                fontFamily: 'Acme',
                                              ),
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Color(
                                                  0xFFFF6600), // Set your desired color for the '*'
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
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
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
                              child: GestureDetector(
                                //https://www.google.com/search?q=how+to+load+a+image+in+firestore+using+flutter&rlz=1C1CHBF_esES1059&oq=how+to+load+a+image+in+firestore+using+&aqs=chrome.1.69i57j33i10i160l5.20310j0j7&sourceid=chrome&ie=UTF-8#kpvalbx=_8L1zZIydJO2rkdUP_ZqwwAI_34
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  imageRecipe = await imagePicker.pickImage(source: ImageSource.gallery);
                                },
                                child: Image.network(
                                  'https://i.imgur.com/zjmuaBZ.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Titulo',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        color: AppColors.brownTextColor,
                                        fontSize: 16,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Color(
                                          0xFFFF6600), // Set your desired color for the '*'
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors
                                .white, // Set the desired background color
                            border: Border.all(
                              color: const Color(
                                  0xFFCCDDD7), // Set the desired border color
                              width: 2.5, // Set the desired border width
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _tituloController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ej: Espagueti a la boloñesa',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              style: const TextStyle(
                                color: AppColors.brownTextColor,
                                fontSize: 16,
                                fontFamily: 'Acme',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Tiempo',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        color: AppColors.brownTextColor,
                                        fontSize: 16,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Color(0xFFFF6600),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  '${_sliderValue.round()} mins',
                                  textAlign: TextAlign
                                      .right, // Align the text to the right

                                  style: const TextStyle(
                                    color: AppColors.brownTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        value: _sliderValue,
                        divisions: 35,
                        min: 5.0,
                        max: 180.0,
                        onChanged: _updateSliderValue,
                        activeColor: AppColors.orangeColor,
                        inactiveColor: const Color(0xFFCCDDD7),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Categorías',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        color: AppColors.brownTextColor,
                                        fontSize: 16,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                      color: Color(0xFFFF6600),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: List.generate(
                              6,
                              (rowIndex) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  4,
                                  (colIndex) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: TextButton(
                                      onPressed: () {
                                        updateButtonState(rowIndex, colIndex);
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize: const Size(90, 35),
                                        backgroundColor:
                                            Colors.white, // Enabled state
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            color: buttonStates[rowIndex]
                                                    [colIndex]
                                                ? AppColors.orangeColor
                                                : Colors
                                                    .transparent, // Border color for enabled buttons
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        buttonTexts[rowIndex][colIndex],
                                        style: GoogleFonts.acme(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Acme',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: Text(
                                      'Paso 1 de 3',
                                      style: GoogleFonts.acme(
                                        textStyle: const TextStyle(
                                          color: Color(0xFF80684C),
                                          fontSize: 15,
                                          fontFamily: 'Acme',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 20, 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Check if _tituloController is not null or empty
                                        if (_tituloController.text.isNotEmpty) {
                                          // Check if at least one button in buttonStates is true
                                          bool isButtonSelected =
                                              buttonStates.any((row) =>
                                                  row.any((col) => col));
                                          if (isButtonSelected) {
                                            // Navigate to the screen where you want to add a recipe
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeFormScreenTwo(
                                                  emailData: widget.emailData,
                                                  nameData: widget.nameData,
                                                  profilePicData: widget.profilePicData,
                                                  usernameData: widget.usernameData,
                                                  tituloRecepie: _tituloController.value.text,
                                                  tiempoRecepie: _sliderValue.toInt(),
                                                  categoriasRecepie: getSelectedButtonValues(),
                                                  imageRecipe: imageRecipe,
                                                ),
                                              ),
                                            );
                                          } else {
                                            showRequired(2);
                                          }
                                        } else {
                                          showRequired(1);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      child: Text(
                                        'Continuar',
                                        style: GoogleFonts.acme(
                                          textStyle: const TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: 16,
                                            fontFamily: 'Acme',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
}


//VERSION ORIGINAL