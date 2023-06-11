import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/SettingsScreen.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/screens/LoginScreen.dart';

import '../screens/ContactScreen.dart';

class MyDrawer extends StatelessWidget {
  final String profilePicData;
  final String nameData;
  final String usernameData;
  final String emailData;
  final String fechaData;

  const MyDrawer({
    Key? key,
    required this.profilePicData,
    required this.nameData,
    required this.usernameData,
    required this.emailData,
    required this.fechaData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0XFFF9EDDE),
      child: ListView(
        children: [
          Container(
            color: const Color.fromARGB(255, 224, 206, 185),
            height: 120,
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 15, 0),
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            profilePicData,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          nameData,
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                        Text(
                          '@$usernameData',
                          style: GoogleFonts.acme(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF576661),
                              fontFamily: 'Acme',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenSize.height - 200,
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Column(
                  children: [
                    const Divider(
                      color: Color.fromARGB(255, 117, 128, 124),
                      thickness: 2,
                      height: 20,
                      indent: 5,
                      endIndent: 50,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.settings_outlined,
                        size: 25,
                        color: Color(0xFF576661),
                      ),
                      title: Text(
                        'Ajustes',
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF576661),
                            fontFamily: 'Alata',
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(
                                emailData: emailData,
                                nameData: nameData,
                                profilePicData: profilePicData,
                                usernameData: usernameData,
                                fechaData: fechaData),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.chat_bubble_outline_outlined,
                        size: 25,
                        color: Color(0xFF576661),
                      ),
                      title: Text(
                        'Contacto',
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF576661),
                            fontFamily: 'Alata',
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactScreen(
                              emailData: emailData,
                              nameData: nameData,
                              profilePicData: profilePicData,
                              usernameData: usernameData,
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: Color(0xFF576661),
                      ),
                      title: Text(
                        'Cerrar sesión',
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF576661),
                            fontFamily: 'Alata',
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
