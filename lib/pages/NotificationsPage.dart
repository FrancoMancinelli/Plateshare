import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/RecipeFormScreenOne.dart';
import 'package:plateshare/util/AppColors.dart';
import 'package:plateshare/widgets/RecipeContainer.dart';

class NotificationsPage extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;
  final String userId;


  const NotificationsPage({
    Key? key, required this.emailData, required this.nameData, required this.usernameData, required this.profilePicData, required this.userId,
  }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
            children: [Row(
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
                          'Notificaciones',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'Acme',
                            ),
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
              ),],
          ),
        ),
      ),
    );
  }
}
