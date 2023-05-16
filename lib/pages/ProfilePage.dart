import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 2,
      decoration: const BoxDecoration(
        color: AppColors.accentColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
                   
        ],
      ),
    );
  }
}
