import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenThree.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plateshare/util/AppColors.dart';

class RecipeFormScreenTwo extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String tituloRecepie;
  final int tiempoRecepie;
  final List<String> categoriasRecepie;

  const RecipeFormScreenTwo({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.tituloRecepie,
    required this.tiempoRecepie,
    required this.categoriasRecepie,
  }) : super(key: key);

  @override
  _RecipeFormScreenTwoState createState() => _RecipeFormScreenTwoState();
}

class _RecipeFormScreenTwoState extends State<RecipeFormScreenTwo> {
  final TextEditingController _racionesController = TextEditingController();

  List<String> texts = [];

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();

  void addTexts() {
    String text1 = textController1.text;
    String text2 = textController2.text;

    if (text1.isNotEmpty && text2.isNotEmpty) {
      setState(() {
        texts.add('$text1 - $text2 $dropdownValue');
      });

      textController1.clear();
      textController2.clear();
    } else {
      showRequired(3);
    }
  }

  void showRequired(int index) {
    switch (index) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Indica la cantidad de raciones para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Agrega al menos 2 ingrediente para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Rellena el nombre del ingrediente y la cantidad para poder añadirlo a la lista'),
            backgroundColor: Colors.red,
          ),
        );
        break;
    }
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 80,
                            color: AppColors.recommendationColor,
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
                              controller: _racionesController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ej: 2',
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
                              ),
                              keyboardType: TextInputType
                                  .number, // Set the keyboard type to number
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter
                                    .digitsOnly, // Restrict input to digits only
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
                                          color: AppColors.recommendationColor,
                                          width: 2.5),
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
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                          color: AppColors.recommendationColor,
                                          width: 2.5),
                                    ),
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      controller: textController2,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter
                                            .digitsOnly, // Restrict input to digits only
                                      ],
                                      style: const TextStyle(
                                        color: AppColors.brownTextColor,
                                        fontSize: 16,
                                        fontFamily: 'Acme',
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                            color:
                                                AppColors.recommendationColor,
                                            width: 2.5),
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
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                color: AppColors.brownTextColor,
                                                fontSize: 15,
                                                fontFamily: 'Acme',
                                              ),
                                            ),
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
                                          color: AppColors.orangeColor,
                                          width: 2.5),
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
                            Container(
                              height: 411,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: texts.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.brownRecepieColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                color: AppColors.orangeColor,
                                                width: 2.5),
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
                            ),
                          ],
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
                                      'Paso 2 de 3',
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
                                        Navigator.pop(
                                            context); // Close the current screen
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                      ),
                                      child: Text(
                                        'Volver',
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 20, 0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print(widget.tituloRecepie);
                                        print(widget.tiempoRecepie);
                                        print(widget.categoriasRecepie);
                                        if (_racionesController
                                            .text.isNotEmpty) {
                                          if (texts.length >= 2) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RecipeFormScreenThree(
                                                  emailData: widget.emailData,
                                                  nameData: widget.nameData,
                                                  profilePicData: widget.profilePicData,
                                                  usernameData: widget.usernameData,
                                                  tituloRecepie: widget.tituloRecepie,
                                                  tiempoRecepie: widget.tiempoRecepie,
                                                  categoriasRecepie: widget.categoriasRecepie,
                                                  racionesRecepie: _racionesController.value.text,
                                                  ingredientesRecepie: texts,
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