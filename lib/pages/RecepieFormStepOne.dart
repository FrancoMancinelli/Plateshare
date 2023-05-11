import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormStepOne extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const RecipeFormStepOne({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _RecipeFormStepOneState createState() => _RecipeFormStepOneState();
}

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
  (index) => List.generate(4, (index) => false),
);

class _RecipeFormStepOneState extends State<RecipeFormStepOne> {
  final TextEditingController _tituloController = TextEditingController();
  double _sliderValue = 45.0;

  void _updateSliderValue(double newValue) {
    setState(() {
      _sliderValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // set all selection states to false
                                  setState(() {
                                    buttonStates = List.generate(
                                        6,
                                        (index) =>
                                            List.generate(4, (index) => false));
                                  });
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
                                child: const Text(
                                  'Abandonar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
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
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
                child: GestureDetector(
                  onTap: () {
                    print('Image tapped!');
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
          padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
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
              borderRadius: BorderRadius.circular(20),
              color: Colors.white, // Set the desired background color
              border: Border.all(
                color: const Color(0xFFCCDDD7), // Set the desired border color
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                    textAlign: TextAlign.right, // Align the text to the right

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
                      padding: EdgeInsets.symmetric(horizontal: 3.0),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            buttonStates[rowIndex][colIndex] =
                                !buttonStates[rowIndex][colIndex];
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(90, 35), // Set desired button size
                          backgroundColor: AppColors.whiteColor,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(
                              color: buttonStates[rowIndex][colIndex]
                                  ? AppColors.orangeColor
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          buttonTexts[rowIndex][colIndex],
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              color: AppColors.brownTextColor,
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

        //zzzzzz
      ],
    );
  }
}
