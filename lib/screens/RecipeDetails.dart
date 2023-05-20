import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/IngredientContainer.dart';
import 'package:plateshare/widgets/InstructionsContainer.dart';

import 'InicioScreen.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String image;

  const RecipeDetailsScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  _RecipeDetailsScreenState createState() => _RecipeDetailsScreenState();
}

var screenSize;
int flag = 1;

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  Color firstButtonColor = AppColors.lightBrownRecipe;
  Color secondButtonColor = AppColors.brownButtonsRecipe;

  void handleFirstButtonPressed() {
    setState(() {
      secondButtonColor = AppColors.brownButtonsRecipe;
      firstButtonColor = AppColors.brownInfoRecipe;
      flag = 1;
    });
  }

  void handleSecondButtonPressed() {
    setState(() {
      firstButtonColor = AppColors.brownButtonsRecipe;
      secondButtonColor = AppColors.brownInfoRecipe;
      flag = 2;
    });
  }

  Widget buildContainerBasedOnFlag(int flag) {
    if (flag == 1) {
      return const IngredientContainer();
    } else if (flag == 2) {
      return const InstructionsContainer();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            leading: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8.5,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blackColor.withOpacity(0.5),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 100, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 45,
                          color: Colors.black.withOpacity(0.5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_profile_pic.png?alt=media&token=92c2e8f1-5871-4285-8040-8b8df60bae14',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '@username',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 105,
                        height: 45,
                        color: Colors.black.withOpacity(0.5),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Handle favorite button press
                              },
                            ),
                            Text(
                              '0000',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: 1000,
                  color: AppColors.accentColor,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              'Titulo de la receta en cuestion',
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 34,
                                  color: AppColors.brownTextColor,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 10, 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.brownInfoRecipe,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 2, 0, 0),
                                child: Text(
                                  '4.5',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.access_time,
                                color: AppColors.brownInfoRecipe,
                                size: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(3, 2, 0, 0),
                                child: Text(
                                  '60 mins',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(), // Add a spacer to push the next elements to the right
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 2, 0),
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  color: AppColors.brownInfoRecipe,
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Text(
                                  '0 Comentarios',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.brownButtonsRecipe,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            firstButtonColor),
                                  ),
                                  onPressed: handleFirstButtonPressed,
                                  child: Text(
                                    'Ingredientes (0)',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            secondButtonColor),
                                  ),
                                  onPressed: handleSecondButtonPressed,
                                  child: Text(
                                    'Instrucciones',
                                    style: GoogleFonts.acme(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: AppColors.whiteColor,
                                        fontFamily: 'Acme',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        buildContainerBasedOnFlag(flag),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                          child: Container(
                            color: AppColors.greyColor,
                            height: 2,
                            width: screenSize.width,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.brownInfoRecipe,
                                size: 36,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 2, 0, 0),
                                child: Text(
                                  '4.5',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 30,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                child: Text(
                                  '57 Valoraciones',
                                  style: GoogleFonts.acme(
                                    textStyle: const TextStyle(
                                      fontSize: 30,
                                      color: AppColors.brownInfoRecipe,
                                      fontFamily: 'Acme',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.brownButtonsRecipe,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),

                        //END
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
