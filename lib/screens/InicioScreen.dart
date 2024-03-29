import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plateshare/pages/NotificationsPage.dart';
import 'package:plateshare/pages/ProfilePage.dart';
import 'package:plateshare/pages/RecipesPage.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/widgets/MyAppBar.dart';
import 'package:plateshare/widgets/MyDrawer.dart';

import '../util/AppColors.dart';
import 'RecipeFormScreenOne.dart';

class InicioScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const InicioScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _InicioScreenState createState() => _InicioScreenState();
}

dynamic screenSize;

class _InicioScreenState extends State<InicioScreen> {
  final items = <Widget>[
    const Icon(Icons.notifications, size: 30),
    const Icon(Icons.home, size: 30),
    const Icon(Icons.person, size: 30),
  ];

  int _selectedIndex = 1;

  String userId = '';
  int followers = 0;
  int follows = 0;
  int recipeCount = 0;
  List<String> recipesIDs = [];
  List<dynamic> likedRecipesIDs = [];
  String fechaData = '';

  @override
  void initState() {
    super.initState();
    getRecipesIDs();
  }

  // Obtiene la información de cada receta a mostrar en el inicio
  Future<void> getRecipesIDs() async {
    final userIdFromDB = await getDocumentIdByUsername(widget.usernameData);
    final recipesIDsFromUserId = await getRecipeDocumentIDs(userIdFromDB);
    final followersFromDB = await getFollowers(userIdFromDB);
    final followsFromDB = await getFollows(userIdFromDB);
    final likedRecipesIDsFromUserId = await getLikedRecipes(userIdFromDB);
    final fechaCreacion = await getCreationDate(userIdFromDB);
    setState(() {
      userId = userIdFromDB;
      recipesIDs = recipesIDsFromUserId;
      followers = followersFromDB.length;
      follows = followsFromDB.length;
      recipeCount = recipesIDsFromUserId.length;
      likedRecipesIDs = likedRecipesIDsFromUserId;
      fechaData = fechaCreacion;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        //El AppBar y Drawer solo se muestran si la pagina es la de recetas
        appBar: _selectedIndex == 1
            ? MyAppBar(
                emailData: widget.emailData,
                nameData: widget.nameData,
                profilePicData: widget.profilePicData,
                usernameData: widget.usernameData,
              )
            : null,
        drawer: _selectedIndex == 1
            ? MyDrawer(
                nameData: widget.nameData,
                usernameData: widget.usernameData,
                profilePicData: widget.profilePicData,
                emailData: widget.emailData,
                fechaData: fechaData,
              )
            : null,
        body: _getPage(_selectedIndex),
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                backgroundColor: AppColors.orangeColor,
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeFormScreenOne(
                          emailData: widget.emailData,
                          nameData: widget.nameData,
                          profilePicData: widget.profilePicData,
                          usernameData: widget.usernameData),
                    ),
                  );
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: AppColors.whiteColor)),
          child: CurvedNavigationBar(
            color: AppColors.primaryColor,
            backgroundColor: const Color.fromARGB(255, 16, 141, 99),
            buttonBackgroundColor: AppColors.orangeColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 500),
            items: items,
            height: 60,
            index: _selectedIndex,
            onTap: (selectedIndex) =>
                setState(() => _selectedIndex = selectedIndex),
          ),
        ),
      ),
    );
  }

  // Cambia el contenido de la pantalla y muestra una de las paginas según la sección donde se encuentre el usuario
  Widget _getPage(int index) {
    switch (index) {
      case 0: // Notificaciones
        return NotificationsPage(
          emailData: widget.emailData,
          nameData: widget.nameData,
          profilePicData: widget.profilePicData,
          userId: userId,
          usernameData: widget.usernameData,
        );
      case 1: // Recetas | Home
        return RecipesPage(
          userImage: widget.profilePicData,
          userName: widget.nameData,
          userUsername: widget.usernameData,
          userEmail: widget.emailData,
        );
      case 2: // Mi Perfil
        return ProfilePage(
          emailData: widget.emailData,
          usernameData: widget.usernameData,
          nameData: widget.nameData,
          profilePicData: widget.profilePicData,
          followers: followers,
          follows: follows,
          recipeCount: recipeCount,
          recipesIDs: recipesIDs,
          userId: userId,
          likedRecipesIDs: likedRecipesIDs,
        );
      default:
        return Container();
    }
  }
}
