import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/services/firebase_service.dart';
import 'package:http/http.dart' as http;

import '../util/AppColors.dart';
import '../widgets/MyFavoritesContainer.dart';
import '../widgets/MyRecipesContainer.dart';
import 'RecipeFormScreenOne.dart';

class UserProfileScreen extends StatefulWidget {
  final String ownerUsername;
  final int recipeCount;
  final int followers;
  final int follows;
  final String ownerName;
  final String ownerEmail;
  final String ownerImage;
  final String ownerId;
  final List<String> recipesIDs;
  final List<dynamic> likedRecipesIDs;
  
  final String currentUser_username;
  final String currentUser_userId;
  final String currentUser_name;
  final String currentUser_email;
  final String currentUser_image;

  const UserProfileScreen({Key? key, required this.ownerUsername, required this.recipeCount, required this.followers, required this.follows, required this.ownerName, required this.ownerEmail, required this.ownerImage, required this.ownerId, required this.recipesIDs, required this.likedRecipesIDs, required this.currentUser_username, required this.currentUser_userId, required this.currentUser_name, required this.currentUser_email, required this.currentUser_image})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

var screenSizeUserProfileScreen;

class _UserProfileScreenState extends State<UserProfileScreen> {
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
      data = generateDataList(widget.recipeCount, widget.followers, widget.follows);
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
    screenSizeUserProfileScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.accentColor,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _ProfileHeaderDelegate(
                  username: widget.ownerUsername,
                  onBackButtonPressed: () {
                    // Handle left icon button press
                  },
                  onAddButtonPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height:
                              20), // Add spacing between the row and the image
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
                          backgroundImage: NetworkImage(widget.ownerImage),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${widget.ownerName}',
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
                          width: screenSizeUserProfileScreen.width,
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
                                  minimumSize: Size(150, 20),
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
                                  minimumSize: Size(150, 20),
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
                              emailData: widget.currentUser_email,
                              nameData: widget.currentUser_name,
                              profilePicData: widget.currentUser_image,
                              recipesIDs: widget.recipesIDs,
                              userId: widget.currentUser_userId,
                              usernameData: widget.currentUser_username,
                            ),
                          if (flag == 2)
                            MyFavoritesContainer(
                              emailData: widget.currentUser_email,
                              nameData: widget.currentUser_name,
                              profilePicData: widget.currentUser_image,
                              likedRecipesIDs: widget.likedRecipesIDs,
                              userId: widget.currentUser_userId,
                              usernameData: widget.currentUser_username,
                            ),
                        ],
                      )

                      //
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String username;
  final VoidCallback onBackButtonPressed;
  final VoidCallback onAddButtonPressed;

  _ProfileHeaderDelegate({
    required this.username,
    required this.onBackButtonPressed,
    required this.onAddButtonPressed,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50,
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
              onPressed: onBackButtonPressed,
            ),
          ),
          Text(
            '@$username',
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
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
              onPressed: onAddButtonPressed,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(_ProfileHeaderDelegate oldDelegate) {
    return username != oldDelegate.username ||
        onBackButtonPressed != oldDelegate.onBackButtonPressed ||
        onAddButtonPressed != oldDelegate.onAddButtonPressed;
  }
}
