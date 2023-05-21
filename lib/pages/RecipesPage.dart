import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';
import 'dart:math';

import '../services/firebase_service.dart';

class RecipesPage extends StatelessWidget {
  final String userImage;
  final String userName;
  final String userUsername;

  RecipesPage({
    Key? key, required this.userImage, required this.userName, required this.userUsername,
  }) : super(key: key);

  List<String> listClasificaciones = [
    'Saludable',
    'Económicas',
    "En menos de 15'",
    'Postres',
    'Veganas',
    'Vegetarianas',
    'Gluten free',
    'Sin lactosa',
    'Calientes',
    'Fríos',
    'Tradicional',
    'De 3 ingredientes',
    'Festivas'
  ];

  Future<List<String>> idRecetasSaludables = getRecepiesFromCategory('Saludable');
  Future<List<String>> idRecetasEconomicas = getRecepiesFromCategory('Económica');
  Future<List<String>> idRecetasEn15Min = getRecepiesLessThan15Min();
  Future<List<String>> idRecetasPostres = getRecepiesFromCategory('Postre');
  Future<List<String>> idRecetasVeganas = getRecepiesFromCategory('Vegano');
  Future<List<String>> idRecetasVegetarianas = getRecepiesFromCategory('Vegetariano');
  Future<List<String>> idRecetasGlutenFree = getRecepiesFromCategory('Gluten free');
  Future<List<String>> idRecetasSinLactosa = getRecepiesFromCategory('Sin lactosa');
  Future<List<String>> idRecetasCalientes = getRecepiesFromCategory('Caliente');
  Future<List<String>> idRecetasFrios = getRecepiesFromCategory('Fríos');
  Future<List<String>> idRecetasTradicional = getRecepiesFromCategory('Tradicional');
  Future<List<String>> idRecetas3Ingredientes = getRecipiesWith3Ingredients();
  Future<List<String>> idRecetasFestivas = getRecepiesFromCategory('Festiva');

  String primeraSeccion = "";
  String segundaSeccion = "";
  String terceraSeccion = "";

  Future<List<Widget>> printRecipes(String categoria) async {
  List<Widget> containers = [];

  switch (categoria) {
  case 'Saludable':
    List<String> recipes = await idRecetasSaludables;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Económicas':
    List<String> recipes = await idRecetasEconomicas;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case "En menos de 15'":
    List<String> recipes = await idRecetasEn15Min;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Postres':
    List<String> recipes = await idRecetasPostres;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Veganas':
    List<String> recipes = await idRecetasVeganas;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Vegetarianas':
    List<String> recipes = await idRecetasVegetarianas;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Gluten free':
    List<String> recipes = await idRecetasGlutenFree;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Sin lactosa':
    List<String> recipes = await idRecetasSinLactosa;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Calientes':
    List<String> recipes = await idRecetasCalientes;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  case 'Fríos':
    List<String> recipes = await idRecetasFrios;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
      case 'Tradicional':
    List<String> recipes = await idRecetasTradicional;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
      case 'De 3 ingredientes':
    List<String> recipes = await idRecetas3Ingredientes;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
    case 'Festivas':
    List<String> recipes = await idRecetasFestivas;
    for (int i = 0; i < 5 && i < recipes.length; i++) {
      String idReceta = recipes[i];
      containers.add(RecipeContainer(idRecepieInDatabase: idReceta, userImage: userImage, userName: userName, userUsername: userUsername,));
    }
    break;
  }


  return containers;
}



  String getRandomClasificationAndRemove() {
    if (listClasificaciones.isEmpty) {
      return ''; // Return an empty string or handle the case when the list is empty
    }

    final random = Random();
    final index = random.nextInt(listClasificaciones.length);
    final element = listClasificaciones[index];
    listClasificaciones.removeAt(index);

    return element;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height * 2,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                child: Text(
                  primeraSeccion = getRandomClasificationAndRemove(),
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Widget>>(
  future: printRecipes(primeraSeccion),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Row(
        children: snapshot.data!,
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return CircularProgressIndicator();
  },
)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  segundaSeccion = getRandomClasificationAndRemove(),
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Widget>>(
  future: printRecipes(segundaSeccion),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Row(
        children: snapshot.data!,
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return CircularProgressIndicator();
  },
)
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text(
                  terceraSeccion = getRandomClasificationAndRemove(),
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 15, 0),
                child: Text(
                  'Ver más',
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: AppColors.brownTextColor,
                      fontFamily: 'Acme',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder<List<Widget>>(
  future: printRecipes(terceraSeccion),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return Row(
        children: snapshot.data!,
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return CircularProgressIndicator();
  },
)
            ),
          ),
        ],
      ),
    );
  }
}
