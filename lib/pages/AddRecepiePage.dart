import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/util/AppColors.dart';

class AddRecepiePage extends StatefulWidget {
  AddRecepiePage({
    Key? key,
  }) : super(key: key);

  @override
  _AddRecepiePageState createState() => _AddRecepiePageState();
}

class _AddRecepiePageState extends State<AddRecepiePage> {
  final TextEditingController _tituloController = TextEditingController();
  double _sliderValue = 30.0;

  void _updateSliderValue(double newValue) {
    setState(() {
      _sliderValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: AppColors.accentColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: screenSize.width,
                color: AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Sube una receta',
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
                          textAlign:
                              TextAlign.right, // Align the text to the right

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
                min: 5.0,
                max: 180.0,
                onChanged: _updateSliderValue,
                activeColor: AppColors.orangeColor,
                inactiveColor: const Color(0xFFCCDDD7),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
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
              //zzzzzz
            ],
          ),
        ),
      ),
    );
  }
}
