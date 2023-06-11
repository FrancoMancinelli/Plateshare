import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';
import 'dart:math';

import '../services/firebase_service.dart';

class RecipesPage extends StatelessWidget {
  final String userImage;
  final String userName;
  final String userUsername;
  final String userEmail;

  RecipesPage({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.userUsername,
    required this.userEmail,
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

  String primeraSeccion = "";
  String segundaSeccion = "";
  String terceraSeccion = "";
  String cuartaSeccion = "";
  String quintaSeccion = "";

  //Rellena una lista de contenedores que muestran las recetas. Segun la categoria indicada añadira ese tipo de recetas a la lista
  Future<List<Widget>> printRecipes(String categoria) async {
    List<Widget> containers = [];

    switch (categoria) {
      case 'Saludable':
        Future<List<String>> idRecetasSaludables =
            getRecipesFromCategory('Saludable');
        List<String> recipes = await idRecetasSaludables;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Económicas':
        Future<List<String>> idRecetasEconomicas =
            getRecipesFromCategory('Económica');
        List<String> recipes = await idRecetasEconomicas;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case "En menos de 15'":
        Future<List<String>> idRecetasEn15Min = getRecepiesLessThan15Min();
        List<String> recipes = await idRecetasEn15Min;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Postres':
        Future<List<String>> idRecetasPostres =
            getRecipesFromCategory('Postre');
        List<String> recipes = await idRecetasPostres;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Veganas':
        Future<List<String>> idRecetasVeganas =
            getRecipesFromCategory('Vegano');
        List<String> recipes = await idRecetasVeganas;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Vegetarianas':
        Future<List<String>> idRecetasVegetarianas =
            getRecipesFromCategory('Vegetariano');
        List<String> recipes = await idRecetasVegetarianas;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Gluten free':
        Future<List<String>> idRecetasGlutenFree =
            getRecipesFromCategory('Gluten free');
        List<String> recipes = await idRecetasGlutenFree;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Sin lactosa':
        Future<List<String>> idRecetasSinLactosa =
            getRecipesFromCategory('Sin lactosa');
        List<String> recipes = await idRecetasSinLactosa;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Calientes':
        Future<List<String>> idRecetasCalientes =
            getRecipesFromCategory('Caliente');
        List<String> recipes = await idRecetasCalientes;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Fríos':
        Future<List<String>> idRecetasFrios = getRecipesFromCategory('Fríos');
        List<String> recipes = await idRecetasFrios;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Tradicional':
        Future<List<String>> idRecetasTradicional =
            getRecipesFromCategory('Tradicional');
        List<String> recipes = await idRecetasTradicional;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'De 3 ingredientes':
        Future<List<String>> idRecetas3Ingredientes =
            getRecipiesWith3Ingredients();
        List<String> recipes = await idRecetas3Ingredientes;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
      case 'Festivas':
        Future<List<String>> idRecetasFestivas =
            getRecipesFromCategory('Festiva');
        List<String> recipes = await idRecetasFestivas;
        for (int i = 0; i < 5 && i < recipes.length; i++) {
          String idReceta = recipes[i];
          containers.add(RecipeContainer(
            idRecepieInDatabase: idReceta,
            userImage: userImage,
            userName: userName,
            userUsername: userUsername,
            userEmail: userEmail,
          ));
        }
        break;
    }

    return containers;
  }

  // Obtiene una categoria de clasificación aleatoria y si es escojida la elimina de la lista
  String getRandomClasificationAndRemove() {
    if (listClasificaciones.isEmpty) {
      return '';
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
      height: screenSize.height,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
      ),
      child: SingleChildScrollView(
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
                      return const CircularProgressIndicator();
                    },
                  )),
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
                      return const CircularProgressIndicator();
                    },
                  )),
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
                      return const CircularProgressIndicator();
                    },
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    cuartaSeccion = getRandomClasificationAndRemove(),
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
                  future: printRecipes(cuartaSeccion),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: snapshot.data!,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Text(
                    cuartaSeccion = getRandomClasificationAndRemove(),
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
                  future: printRecipes(quintaSeccion),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: snapshot.data!,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
