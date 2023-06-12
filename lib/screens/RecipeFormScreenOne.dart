import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenTwo.dart';
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
    ['Vegano', 'Ocasional', 'Bebidas', 'Saludable', 'Caliente', 'Festiva'],
    ['Gluten free', 'Infantil', 'Fríos', 'Proteico', 'Italiana', 'Tradicional'],
    ['Sin lactosa', 'Rápido', 'Económica', 'Postre', 'Asiática', 'Snack'],
    ['Vegetariano', 'Salsas', 'Agridulce', 'Picante', 'Mexicana', 'Fácil'],
  ];

  // Listado con el estado de los botones de categorias
  List<List<bool>> buttonStates = List.generate(
    4,
    (rowIndex) => List.generate(6, (colIndex) => false),
  );

  // Obtiene los botones que hayan sido seleccionados y los devuelve en una List<String>
  List<String> getSelectedButtonValues() {
    List<String> selectedValues = [];

    for (int rowIndex = 0; rowIndex < buttonStates.length; rowIndex++) {
      for (int colIndex = 0;
          colIndex < buttonStates[rowIndex].length;
          colIndex++) {
        if (buttonStates[rowIndex][colIndex]) {
          String value = buttonTexts[rowIndex][colIndex];
          selectedValues.add(value);
        }
      }
    }

    return selectedValues;
  }

  // Actualiza el estado de los botones de categorias
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

  // Muestra mensajes de requerimientos en la parte inferior de la panatalla
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
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecciona primero una imagen para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
    }
  }

  // Actualiza el valor del slider que indica el tiempo
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
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: AppColors.accentColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: screenSize.width,
                    color: AppColors.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          'Sube una receta',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
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
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Continuar',
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          buttonStates = List.generate(
                                              4,
                                              (index) => List.generate(
                                                  6, (index) => false));
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InicioScreen(
                                              emailData: widget.emailData,
                                              nameData: widget.nameData,
                                              profilePicData:
                                                  widget.profilePicData,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                              child: GestureDetector(
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  imageRecipe = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                },
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  child: Image.asset(
                                    'assets/subirimagen.png',
                                    fit: BoxFit.contain,
                                  ),
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
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFCCDDD7),
                              width: 2.5,
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
                                  textAlign: TextAlign.right,
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
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 4.0,
                          tickMarkShape: SliderTickMarkShape.noTickMark,
                        ),
                        child: Slider(
                          value: _sliderValue,
                          divisions: 35,
                          min: 5.0,
                          max: 180.0,
                          onChanged: _updateSliderValue,
                          activeColor: AppColors.orangeColor,
                          inactiveColor: const Color(0xFFCCDDD7),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Categorías (máx 5)',
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
                              4, // Número de filas de botones
                              (rowIndex) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  6, // Número de columnas de botones
                                  (colIndex) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: TextButton(
                                      onPressed: () {
                                        updateButtonState(rowIndex, colIndex);
                                      },
                                      style: TextButton.styleFrom(
                                        minimumSize: const Size(90, 35),
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            color: buttonStates[rowIndex]
                                                    [colIndex]
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
                                        //Comprueba si el usuario introduce una imagen
                                        if (imageRecipe != null &&
                                            imageRecipe!.path.isNotEmpty) {
                                          // Comprueba si el titulo no esta vacio
                                          if (_tituloController
                                              .text.isNotEmpty) {
                                            // Comprueba que al menos una categoria haya sido seleccionada
                                            bool isButtonSelected =
                                                buttonStates.any((row) =>
                                                    row.any((col) => col));
                                            if (isButtonSelected) {
                                              // Continua al paso 2
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecipeFormScreenTwo(
                                                    emailData: widget.emailData,
                                                    nameData: widget.nameData,
                                                    profilePicData:
                                                        widget.profilePicData,
                                                    usernameData:
                                                        widget.usernameData,
                                                    tituloRecepie:
                                                        _tituloController
                                                            .value.text,
                                                    tiempoRecepie:
                                                        _sliderValue.toInt(),
                                                    categoriasRecepie:
                                                        getSelectedButtonValues(),
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
                                        } else {
                                          showRequired(3);
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
            ],
          ),
        ),
      ),
    );
  }
}
