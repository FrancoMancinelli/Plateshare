import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/firebase_service.dart';
import '../util/AppColors.dart';
import '../widgets/ProfileRecipes.dart';
import 'InicioScreen.dart';

class SearchScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const SearchScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

var screenSizeContactScreen;

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? selectedCheckbox = 'ingredientes';
  List<String> busquedaRealizada = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    getId();
  }

  Future<void> getId() async {
    final id = await getDocumentIdByUsername(widget.usernameData);
    setState(() {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSizeContactScreen = MediaQuery.of(context).size;
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
                        'Buscador',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.greyAccentColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      decoration: InputDecoration(
                                        labelText: 'Buscar...',
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                15, 10, 0, 15),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                            color: AppColors.desabledField,
                                            width: 3.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          borderSide: BorderSide(
                                            color: AppColors.primaryColor,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Container(
                                    height: 45,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.brownButtonsRecipe,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      onPressed: () async {
                                        if (_searchController.text.isNotEmpty) {
                                          if (selectedCheckbox ==
                                              'ingredientes') {
                                            String busquedaCompleta =
                                                _searchController.text;
                                            List<String> busquedaDividida =
                                                busquedaCompleta.split(',');
                                            List<String> recetasEncontradas =
                                                await searchRecipesByIngredients(
                                                    busquedaDividida);
                                             setState(() {
                                              busquedaRealizada = recetasEncontradas;
                                            });
                                          }

                                          if (selectedCheckbox == 'titulos') {
                                            List<String> recetasEncontradas =
                                                await searchRecipesByTitle(
                                                    _searchController.text);
                                             setState(() {
                                              busquedaRealizada = recetasEncontradas;
                                            });
                                          }
                                          if (selectedCheckbox == 'usuarios') {
                                            List<String> usuariosEncontrados =
                                                await searchUsersByUsername(
                                                    _searchController.text);
                                             setState(() {
                                              busquedaRealizada = usuariosEncontrados;
                                            });
                                            print('USUARIOS::' +
                                                usuariosEncontrados.length
                                                    .toString());
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.search,
                                        size: 25,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Filtrar por:',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                    color: AppColors.brownTextColor,
                                    fontSize: 16,
                                    fontFamily: 'Acme',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCheckbox = 'ingredientes';
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCheckbox == 'ingredientes'
                                        ? AppColors.primaryColor
                                        : AppColors.desabledField,
                                  ),
                                  child: selectedCheckbox == 'ingredientes'
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Ingredientes',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                    color: AppColors.brownTextColor,
                                    fontSize: 16,
                                    fontFamily: 'Acme',
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCheckbox = 'titulos';
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCheckbox == 'titulos'
                                        ? AppColors.primaryColor
                                        : AppColors.desabledField,
                                  ),
                                  child: selectedCheckbox == 'titulos'
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Titulos',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                    color: AppColors.brownTextColor,
                                    fontSize: 16,
                                    fontFamily: 'Acme',
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCheckbox = 'usuarios';
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selectedCheckbox == 'usuarios'
                                        ? AppColors.primaryColor
                                        : AppColors.desabledField,
                                  ),
                                  child: selectedCheckbox == 'usuarios'
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Usuarios',
                                style: GoogleFonts.acme(
                                  textStyle: const TextStyle(
                                    color: AppColors.brownTextColor,
                                    fontSize: 16,
                                    fontFamily: 'Acme',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (busquedaRealizada.isEmpty)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    Lottie.network(
                                      'https://assets9.lottiefiles.com/packages/lf20_t9nbbl1t.json',
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      'No se ha encontrado ninguna receta',
                                      style: GoogleFonts.acme(
                                        textStyle: const TextStyle(
                                          fontSize: 25,
                                          color: AppColors.brownInfoRecipe,
                                          fontFamily: 'Acme',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (busquedaRealizada.isNotEmpty &&
                                (selectedCheckbox == 'ingredientes' ||
                                    selectedCheckbox == 'titulos'))
                              for (int i = 0;
                                  i < busquedaRealizada.length;
                                  i += 2)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        ProfileRecipes(
                                          idRecepieInDatabase:
                                              busquedaRealizada[i],
                                          userImage: widget.profilePicData,
                                          userName: widget.nameData,
                                          userUsername: widget.usernameData,
                                          screenWidth: screenSize.width,
                                          userId: userId,
                                          userEmail: widget.emailData,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        if (i + 1 < busquedaRealizada.length)
                                          ProfileRecipes(
                                            idRecepieInDatabase:
                                                busquedaRealizada[i + 1],
                                            userImage: widget.profilePicData,
                                            userName: widget.nameData,
                                            userUsername: widget.usernameData,
                                            screenWidth: screenSize.width,
                                            userId: userId,
                                            userEmail: widget.emailData,
                                          ),
                                        if (i + 1 >= busquedaRealizada.length)
                                          Container(
                                            width: screenSize.width / 2,
                                            height: 245,
                                            color: AppColors.accentColor,
                                          ),
                                      ],
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
    );
  }
}
