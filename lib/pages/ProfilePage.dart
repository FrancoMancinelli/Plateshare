import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/MyRecipesContainer.dart';

import '../screens/RecipeFormScreenOne.dart';
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

  const ProfilePage({
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

dynamic screenSize;

class _ProfilePageState extends State<ProfilePage> {
  Color menuButtonColor = AppColors.brownRecepieColor;
  Color favoriteButtonColor = AppColors.accentColor;

  List<Map<String, dynamic>> data = [];

  int flag = 1;

  // Actualiza el estado de los botones al ser pulsado el botón de recetas
  void handleMenuButtonTap() {
    setState(() {
      menuButtonColor = AppColors.brownRecepieColor;
      favoriteButtonColor = AppColors.accentColor;
      flag = 1;
    });
  }

  // Actualiza el estado de los botones al ser pulsado el botón de favoritos
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

  //Genera una lista de datos del perfil como la cantidad de recetas publicadas y la cantidad de seguidores y seguidos
  Future<void> getProfileData() async {
    setState(() {
      data = generateDataList(
          widget.recipeCount, widget.followers, widget.follows);
    });
  }

  // Genera una mapa dinamico con la información del perfil
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
        color: AppColors.accentColor,
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _ProfileHeaderDelegate(
                username: widget.usernameData,
                onBackButtonPressed: () {
                  // Handle left icon button press
                },
                onAddButtonPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeFormScreenOne(
                        emailData: widget.emailData,
                        nameData: widget.nameData,
                        profilePicData: widget.profilePicData,
                        usernameData: widget.usernameData,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
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
                        backgroundImage: NetworkImage(widget.profilePicData),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.nameData,
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
                                minimumSize: const Size(150, 20),
                              ),
                              child: const Icon(Icons.restaurant_menu_rounded,
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
                                minimumSize: const Size(150, 20),
                              ),
                              child: const Icon(Icons.favorite_border_outlined,
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
                            nameData: widget.nameData,
                            profilePicData: widget.profilePicData,
                            recipesIDs: widget.recipesIDs,
                            userId: widget.userId,
                            usernameData: widget.usernameData,
                            ownerId: widget.userId,
                          ),
                        if (flag == 2)
                          MyFavoritesContainer(
                            emailData: widget.emailData,
                            nameData: widget.nameData,
                            profilePicData: widget.profilePicData,
                            likedRecipesIDs: widget.likedRecipesIDs,
                            usernameData: widget.usernameData,
                            userId: widget.userId,
                            ownerId: widget.userId,
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
    );
  }
}

//Clase para mostrar la cabecera de la pagina
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
                size: 20,
              ),
              onPressed: onBackButtonPressed,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '@$username',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (username == 'plateshare')
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
                      child: Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 30,
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
