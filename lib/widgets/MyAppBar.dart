import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/SearchScreen.dart';
import 'package:plateshare/util/AppColors.dart';

import '../screens/InicioScreen.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String emailData;
  final String nameData;
  final String profilePicData;
  final String usernameData;
  MyAppBar({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.profilePicData,
    required this.usernameData,
  }) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  String _searchErrorText = '';

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        'Inicio',
        style: GoogleFonts.acme(
          textStyle: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 25,
            fontFamily: 'Acme',
          ),
        ),
      ),
      centerTitle: true, // Add this line to center the title
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    emailData: emailData,
                    nameData: nameData,
                    profilePicData: profilePicData,
                    usernameData: usernameData,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ),
      ],
    );
  }
}
