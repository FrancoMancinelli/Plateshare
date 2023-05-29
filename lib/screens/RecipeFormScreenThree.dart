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

class RecipeFormScreenThree extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String tituloRecepie;
  final int tiempoRecepie;
  final List<String> categoriasRecepie;
  final String racionesRecepie;
  final List<String> ingredientesRecepie;
  final XFile? imageRecipe;

  const RecipeFormScreenThree({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
    required this.tituloRecepie,
    required this.tiempoRecepie,
    required this.categoriasRecepie,
    required this.racionesRecepie,
    required this.ingredientesRecepie, required this.imageRecipe,
  }) : super(key: key);

  @override
  _RecipeFormScreenThreeState createState() => _RecipeFormScreenThreeState();
}

class _RecipeFormScreenThreeState extends State<RecipeFormScreenThree> {
  final TextEditingController _tituloController = TextEditingController();

  List<String> texts = [];
  TextEditingController textController1 = TextEditingController();

  void addTexts() {
    String text1 = textController1.text;

    if (text1.isNotEmpty) {
      setState(() {
        texts.add(text1);
      });

      textController1.clear();
    } else {
      showLowMessage(1);
    }
  }

  void showLowMessage(int index) {
    switch (index) {
      case 1:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Asegurate de rellenar el campo para poder añadir un nuevo paso a la lista'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Agrega al menos 1 paso a seguir para poder continuar'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 3:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receta agregada con éxito'),
            backgroundColor: Colors.green,
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

  String imageUrl = '';

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
                                      'Por favor, brinde una descripción detallada de los pasos a seguir en la elaboración de la receta para aquellas personas que tienen menos experiencia en la cocina.',
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
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Pasos a seguir   ',
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
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          children: [
                            Container(
                              width: screenSize.width / 1.15,
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: 508,
                          child: ListView.builder(
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
                                              fontSize: 16,
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
                                      'Paso 3 de 3',
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
                                      onPressed: () async {
                                        
                                          if(widget.imageRecipe != null) {
                                            String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();                                  
                                            Reference referenceRoot = FirebaseStorage.instance.ref();
                                            Reference referenceDirImages = referenceRoot.child('imgaes');

                                            Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
                                            try{
                                              await referenceImageToUpload.putFile(File(widget.imageRecipe!.path));
                                              imageUrl = await referenceImageToUpload.getDownloadURL();
                                            
                                            } catch (erorr){
                                            }
                                          }

                                        if (texts.length >= 1) {
                                          final recipeData = {
                                            'category': widget.categoriasRecepie,
                                            'likes': [],
                                            'steps': texts,
                                            'rate': 0.0,
                                            'rations': widget.racionesRecepie,
                                            'time': widget.tiempoRecepie,
                                            'title': widget.tituloRecepie,
                                            'image': imageUrl,
                                          };

                                          

                                          final ingredientList = widget.ingredientesRecepie;
                                          String? documentId = await getDocumentIdByUsername(widget.usernameData);
                                          addRecipeToUser(documentId, recipeData, ingredientList);
                                          
                                          Navigator.push(
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
                                                          widget.usernameData),
                                            ),
                                          );
                                          showLowMessage(3);
                                        } else {
                                          showLowMessage(2);
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
                                        'Publicar',
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
