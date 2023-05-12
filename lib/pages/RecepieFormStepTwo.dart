import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/pages/RecepieFormStepOne.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormStepTwo extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const RecipeFormStepTwo({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);
  @override
  _RecipeFormStepTwoState createState() => _RecipeFormStepTwoState();
}

class _RecipeFormStepTwoState extends State<RecipeFormStepTwo> {
  final TextEditingController _tituloController = TextEditingController();

  List<String> texts = [];

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  void addTexts() {
    String text1 = textController1.text;
    String text2 = textController2.text;

    setState(() {
      texts.add('$text1 - $text2 $dropdownValue');
    });

    textController1.clear();
    textController2.clear();
  }

  void deleteText(int index) {
    setState(() {
      texts.removeAt(index);
    });
  }

  String dropdownValue = 'Litros'; // Declare dropdownValue variable

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
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 80,
              color: AppColors.recomendationColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.lightbulb_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Asegurate de verificar que las cantidades de cada ingrediente se correspondan con la cantidad de raciones indicada.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            color: AppColors.brownTextColor,
                            fontSize: 15,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
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
                      text: 'Raciones',
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
          padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
  height: 50,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    border: Border.all(
      color: const Color(0xFFCCDDD7),
      width: 2.5,
    ),
  ),
  child: TextField(
    controller: _tituloController,
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Ej: 2',
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
    ),
    keyboardType: TextInputType.number, // Set the keyboard type to number
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly, // Restrict input to digits only
    ],
  ),
),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ingredientes',
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

        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.recomendationColor, width: 2.5),
                      ),
                      child: TextField(
                        controller: textController1,
                        style: const TextStyle(
                          color: AppColors.brownTextColor,
                          fontSize: 15,
                          fontFamily: 'Acme',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.recomendationColor, width: 2.5),
                      ),
                      child: TextField(
                            textAlign: TextAlign.center,

                        controller: textController2,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly, // Restrict input to digits only
    ],
                        style: const TextStyle(
                          color: AppColors.brownTextColor,
                          fontSize: 16,
                          fontFamily: 'Acme',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          border: Border.all(
                              color: AppColors.recomendationColor, width: 2.5),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: dropdownValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          items: [
                            'Litros',
                            'Gramos',
                            'Unidades',
                            'Mililitros',
                            'Cazos',
                            'Cucharadas',
                            'Cucharaditas',
                            'Filetes',
                            'Envases',
                            'Tiras',
                            'Hojas',
                            'Latas',
                            'Lonchas',
                            'Onzas',
                            'Paquetes',
                            'Piezas',
                            'Puñados',
                            'Pizca',
                            'Ramas',
                            'Rebanadas',
                            'Rodajas',
                            'Sobres',
                            'Tarinas',
                            'Tazas',
                            'Vasos',
                            'Raciones',
                            'Botes'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: const TextStyle(
                          color: AppColors.brownTextColor,
                          fontSize: 15,
                          fontFamily: 'Acme',
                        ),),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: AppColors.orangeColor, width: 2.5),
                      ),
                      child: InkWell(
                        onTap: addTexts,
                        child: const Icon(
                          Icons.add_rounded,
                          color: AppColors.orangeColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: texts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.brownRecepieColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Text(
                              texts[index],
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 18,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.orangeColor, width: 2.5),
                          ),
                          child: InkWell(
                            onTap: () {
                              deleteText(index);
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: AppColors.orangeColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        //ZZZZ
      ],
    );
  }
}
