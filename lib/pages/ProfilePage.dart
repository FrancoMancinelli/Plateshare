import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Color menuButtonColor = AppColors.brownRecepieColor;
  Color favoriteButtonColor = AppColors.accentColor;

  void handleMenuButtonTap() {
    setState(() {
      menuButtonColor = AppColors.brownRecepieColor;
      favoriteButtonColor = AppColors.accentColor;
    });
  }

  void handleFavoriteButtonTap() {
    setState(() {
      favoriteButtonColor = AppColors.brownRecepieColor;
      menuButtonColor = AppColors.accentColor;
    });
  }

  List<Map<String, dynamic>> data = [
    {'count': '0', 'label': 'Recetas'},
    {'count': '21', 'label': 'Seguidores'},
    {'count': '896', 'label': 'Seguidos'},
  ];

  @override
  Widget build(BuildContext context) {
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
                          '@username',
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
                              // Handle right icon button press
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
                  backgroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/plateshare-tfg2023.appspot.com/o/default_profile_pic.png?alt=media&token=92c2e8f1-5871-4285-8040-8b8df60bae14'),
                ),
              ),
              
              SizedBox(height: 10), // Add spacing between the image and the text
              Text(
                'Fran Mancinelli',
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
                          minimumSize:
                              Size(170, 20), // Set the desired width and height
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
                          minimumSize:
                              Size(170, 20), // Set the desired width and height
                        ),
                        child: Icon(Icons.favorite_border_outlined,
                            size: 24, color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ),
              
              SingleChildScrollView(
                child: Container(
                  color: AppColors.greyAccentColor,
                  width: screenSize.width,
                  height: screenSize.height/1.5,
              
                ),
              ),
              
              //
            ],
          ),
        ),
      ),
    );
  }
}
