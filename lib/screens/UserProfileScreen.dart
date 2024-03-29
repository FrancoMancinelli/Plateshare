import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/services/firebase_service.dart';

import '../util/AppColors.dart';
import '../widgets/MyFavoritesContainer.dart';
import '../widgets/MyRecipesContainer.dart';

class UserProfileScreen extends StatefulWidget {
  final String ownerUsername;
  final int recipeCount;
  final int follows;
  final String ownerName;
  final String ownerEmail;
  final String ownerImage;
  final String ownerId;
  final List<String> recipesIDs;
  final List<dynamic> likedRecipesIDs;

  final String currentUserusername;
  final String currentUseruserId;
  final String currentUsername;
  final String currentUseremail;
  final String currentUserimage;

  const UserProfileScreen(
      {Key? key,
      required this.ownerUsername,
      required this.recipeCount,
      required this.follows,
      required this.ownerName,
      required this.ownerEmail,
      required this.ownerImage,
      required this.ownerId,
      required this.recipesIDs,
      required this.likedRecipesIDs,
      required this.currentUserusername,
      required this.currentUseruserId,
      required this.currentUsername,
      required this.currentUseremail,
      required this.currentUserimage})
      : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

dynamic screenSizeUserProfileScreen;

class _UserProfileScreenState extends State<UserProfileScreen> {
  Color menuButtonColor = AppColors.brownRecepieColor;
  Color favoriteButtonColor = AppColors.accentColor;

  List<Map<String, dynamic>> data = [];

  int flag = 1;

  String buttonText = 'Seguir';
  Color buttonColor = AppColors.primaryColor;
  int actualFollowers = 0;

  // Actualiza el botón de seguir/dejar de seguir y actualiza la información en la base de datos
  void changeButtonProperties() {
    setState(() {
      if (buttonText == 'Seguir') {
        buttonText = 'Dejar de seguir';
        buttonColor = AppColors.orangeColor;
        addFollower(widget.ownerId, widget.currentUseruserId);
        addMyFollows(widget.currentUseruserId, widget.ownerId);
        addNewNotification(
            widget.ownerId,
            '${widget.currentUsername} te ha comenzado a seguir',
            2,
            widget.currentUserimage);
        actualFollowers++;

        final followersIndex =
            data.indexWhere((item) => item['label'] == 'Seguidores');
        if (followersIndex != -1) {
          data[followersIndex]['count'] = actualFollowers.toString();
        }
      } else {
        buttonText = 'Seguir';
        buttonColor = AppColors.primaryColor;
        removeFollower(widget.ownerId, widget.currentUseruserId);
        removeMyFollows(widget.currentUseruserId, widget.ownerId);
        actualFollowers--;

        // Update the 'Seguidores' value in the 'data' list
        final followersIndex =
            data.indexWhere((item) => item['label'] == 'Seguidores');
        if (followersIndex != -1) {
          data[followersIndex]['count'] = actualFollowers.toString();
        }
      }
    });
  }

  // Actualiza los colores de los botones y la bandera si es apretado el boton de recetas
  void handleMenuButtonTap() {
    setState(() {
      menuButtonColor = AppColors.brownRecepieColor;
      favoriteButtonColor = AppColors.accentColor;
      flag = 1;
    });
  }

  // Actualiza los colores de los botones y la bandera si es apretado el boton de favoritos
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

  // Obtiene datos generales del usuario dueño del perfil
  Future<void> getProfileData() async {
    final isFollowed =
        await checkIfFollowsExist(widget.currentUseruserId, widget.ownerId);
    final followersDB = await getFollowers(widget.ownerId);
    setState(() {
      actualFollowers = followersDB.length;
      data =
          generateDataList(widget.recipeCount, actualFollowers, widget.follows);
      if (isFollowed) {
        buttonText = 'Dejar de seguir';
        buttonColor = AppColors.orangeColor;
      }
    });
  }

  // Genera en forma de lista los datos de cantidad de recetas, followers y follows.
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
                  onBackButtonPressed: () {},
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
                      Text(
                        widget.ownerName,
                        style: GoogleFonts.acme(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            color: AppColors.blackColor,
                            fontFamily: 'Acme',
                          ),
                        ),
                      ),
                      if (widget.currentUseruserId != widget.ownerId)
                        ElevatedButton(
                          onPressed: changeButtonProperties,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(buttonColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                            child: Text(
                              buttonText,
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.whiteColor,
                                  fontFamily: 'Acme',
                                ),
                              ),
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
                                child: const Icon(
                                    Icons.favorite_border_outlined,
                                    size: 24,
                                    color: AppColors.blackColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          if (flag == 1)
                            MyRecipesContainer(
                              emailData: widget.currentUseremail,
                              nameData: widget.currentUsername,
                              profilePicData: widget.currentUserimage,
                              recipesIDs: widget.recipesIDs,
                              userId: widget.currentUseruserId,
                              usernameData: widget.currentUserusername,
                              ownerId: widget.ownerId,
                            ),
                          if (flag == 2)
                            MyFavoritesContainer(
                              emailData: widget.currentUseremail,
                              nameData: widget.currentUsername,
                              profilePicData: widget.currentUserimage,
                              likedRecipesIDs: widget.likedRecipesIDs,
                              userId: widget.currentUseruserId,
                              usernameData: widget.currentUserusername,
                              ownerId: widget.ownerId,
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
    );
  }
}

// Classe que contiene el widget de la cabecera
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
