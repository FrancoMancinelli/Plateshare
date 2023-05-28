import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenOne.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/MyRecipesContainer.dart';
import 'package:plateshare/widgets/ProfileRecipes.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';

import '../widgets/MyFavoritesContainer.dart';

class ProfilePage extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  final String userId;
  final int followers;
  final int follows;
  final int recipeCount;
  final List<String> recipesIDs;
  final List<dynamic> likedRecipesIDs;

  ProfilePage({
    Key? key,
    required this.usernameData,
    required this.nameData,
    required this.profilePicData,
    required this.emailData,
    required this.userId,
    required this.followers,
    required this.follows,
    required this.recipeCount,
    required this.recipesIDs,
    required this.likedRecipesIDs,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

var screenSize;

class _ProfilePageState extends State<ProfilePage> {
  Color menuButtonColor = AppColors.brownRecepieColor;
  Color favoriteButtonColor = AppColors.accentColor;

  List<Map<String, dynamic>> data = [];

  int flag = 1;

  void handleMenuButtonTap() {
    setState(() {
      menuButtonColor = AppColors.brownRecepieColor;
      favoriteButtonColor = AppColors.accentColor;
      flag = 1;
    });
  }

  void handleFavoriteButtonTap() {
    setState(() {
      favoriteButtonColor = AppColors.brownRecepieColor;
      menuButtonColor = AppColors.accentColor;
      flag = 2;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  Future<void> getProfileData() async {
    setState(() {
      data = generateDataList(
          widget.recipeCount, widget.followers, widget.follows);
    });
  }

  List<Map<String, dynamic>> generateDataList(
      int recipeCount, int followers, int follows) {
    return [
      {'count': recipeCount.toString(), 'label': 'Recetas'},
      {'count': followers.toString(), 'label': 'Seguidores'},
      {'count': follows.toString(), 'label': 'Seguidos'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
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
                children: [
                  Container(
                    height: 50,
                    width: screenSize.width,
                    color: AppColors.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            onPressed: () {
                              // Handle left icon button press
                            },
                          ),
                        ),
                        Text(
                          '@${widget.usernameData}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_rounded,
                              color: Colors.white,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Add spacing between the row and the image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(widget.profilePicData),
                ),
              ),

              SizedBox(height: 10),
              Text(
                '${widget.nameData}',
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                    fontSize: 24,
                    color: AppColors.blackColor,
                    fontFamily: 'Acme',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: data.map((item) {
                        return Column(
                          children: [
                            Text(
                              item['count'],
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.blackColor,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                            Text(
                              item['label'],
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.greyColor,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: Container(
                  color: AppColors.greyColor,
                  width: screenSize.width,
                  height: 1,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: handleMenuButtonTap,
                        style: TextButton.styleFrom(
                          backgroundColor: menuButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(170, 20),
                        ),
                        child: Icon(Icons.restaurant_menu_rounded,
                            size: 24, color: AppColors.blackColor),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: handleFavoriteButtonTap,
                        style: TextButton.styleFrom(
                          backgroundColor: favoriteButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(170, 20),
                        ),
                        child: Icon(Icons.favorite_border_outlined,
                            size: 24, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  if (flag == 1)
                    MyRecipesContainer(
                      emailData: widget.emailData,
                      followers: widget.followers,
                      follows: widget.follows,
                      nameData: widget.nameData,
                      profilePicData: widget.profilePicData,
                      recipeCount: widget.recipeCount,
                      recipesIDs: widget.recipesIDs,
                      userId: widget.userId,
                      usernameData: widget.usernameData,
                    ),
                  if (flag == 2)
                    MyFavoritesContainer(
                      nameData: widget.nameData,
                      profilePicData: widget.profilePicData,
                      likedRecipesIDs: widget.likedRecipesIDs,
                      usernameData: widget.usernameData,
                    ),
                ],
              )

              //
            ],
          ),
        ),
      ),
    );
  }
}
