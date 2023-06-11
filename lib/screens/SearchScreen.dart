import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/screens/UserProfileScreen.dart';

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
  bool firstflag = true;

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
                                          firstflag = false;
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
                                              busquedaRealizada =
                                                  recetasEncontradas;
                                            });
                                          }

                                          if (selectedCheckbox == 'titulos') {
                                            List<String> recetasEncontradas =
                                                await searchRecipesByTitle(
                                                    _searchController.text);
                                            setState(() {
                                              busquedaRealizada =
                                                  recetasEncontradas;
                                            });
                                          }
                                          if (selectedCheckbox == 'usuarios') {
                                            List<String> usuariosEncontrados =
                                                await searchUsersByUsername(
                                                    _searchController.text);
                                            setState(() {
                                              busquedaRealizada =
                                                  usuariosEncontrados;
                                            });
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Introduce algúna palabra clave de busqueda primero'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
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
                                    color: AppColors.blackColor,
                                    fontSize: 18,
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
                            if (busquedaRealizada.isEmpty && !firstflag)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    Lottie.network(
                                      'https://assets2.lottiefiles.com/packages/lf20_wnqlfojb.json',
                                      width: 300,
                                      height: 200,
                                    ),
                                    Text(
                                      'No se ha encontrado ningún resultado',
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
                            if (busquedaRealizada.isNotEmpty &&
                                selectedCheckbox == 'usuarios')
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: busquedaRealizada.length,
                                itemBuilder: (context, index) {
                                  String elemento = busquedaRealizada[index];
                                  return FutureBuilder<DocumentSnapshot>(
                                    future: getUserDataById(elemento),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error fetching user data');
                                      } else if (!snapshot.hasData) {
                                        return Text('No user data found');
                                      } else {
                                        String name =
                                            snapshot.data!.get('name');
                                        String username =
                                            snapshot.data!.get('username');
                                        String profilePic =
                                            snapshot.data!.get('profilepic');
                                        List<dynamic> followsList =
                                            snapshot.data!.get('follows');

                                        List<dynamic> likedRecipes =
                                            snapshot.data!.get('favorites');
                                        String email =
                                            snapshot.data!.get('email');

                                        return FutureBuilder<List<String>>(
                                          future:
                                              getRecipeDocumentIDs(elemento),
                                          builder: (context, recipeSnapshot) {
                                            if (recipeSnapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (recipeSnapshot
                                                .hasError) {
                                              return Text(
                                                  'Error fetching recipe data');
                                            } else if (!recipeSnapshot
                                                .hasData) {
                                              return Text(
                                                  'No recipe data found');
                                            } else {
                                              List<String> recipes =
                                                  recipeSnapshot.data!;

                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfileScreen(
                                                        currentUseremail:
                                                            widget.emailData,
                                                        currentUserimage: widget
                                                            .profilePicData,
                                                        currentUsername:
                                                            widget.nameData,
                                                        currentUseruserId:
                                                            userId,
                                                        currentUserusername:
                                                            widget.usernameData,
                                                        follows:
                                                            followsList.length,
                                                        likedRecipesIDs:
                                                            likedRecipes,
                                                        ownerEmail: email,
                                                        ownerId: elemento,
                                                        ownerImage: profilePic,
                                                        ownerName: name,
                                                        ownerUsername: username,
                                                        recipeCount:
                                                            recipes.length,
                                                        recipesIDs: recipes,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ClipOval(
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1.5,
                                                              ),
                                                            ),
                                                            child: CircleAvatar(
                                                              radius: 25,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      profilePic),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '@$username',
                                                                style:
                                                                    GoogleFonts
                                                                        .acme(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    color: AppColors
                                                                        .brownTextColor,
                                                                    fontSize:
                                                                        22,
                                                                    fontFamily:
                                                                        'Acme',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .desabledField,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }
                                    },
                                  );
                                },
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
