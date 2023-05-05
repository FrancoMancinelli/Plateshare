import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/screens/LoginScreen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
    required this.profilePicData,
    required this.nameData,
    required this.usernameData,
  }) : super(key: key);

  final String profilePicData;
  final String nameData;
  final String usernameData;

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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            nameData,
                            style: GoogleFonts.acme(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Acme',
                              ),
                            ),
                          ),
                          Text(
                            '@${usernameData}',
                            style: GoogleFonts.acme(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF576661),
                                fontFamily: 'Acme',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person_outlined,
                  size: 25,
                  color: Color(0xFF576661),
                ),
                title: Text(
                  'Mi perfil',
                  style: GoogleFonts.alata(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF576661),
                      fontFamily: 'Alata',
                    ),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_outline,
                  size: 25,
                  color: Color(0xFF576661),
                ),
                title: Text(
                  'Mis favoritos',
                  style: GoogleFonts.alata(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF576661),
                      fontFamily: 'Alata',
                    ),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.now_wallpaper_outlined,
                  size: 25,
                  color: Color(0xFF576661),
                ),
                title: Text(
                  'Historial de Escaneos',
                  style: GoogleFonts.alata(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF576661),
                      fontFamily: 'Alata',
                    ),
                  ),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_outlined,
                  size: 25,
                  color: Color(0xFF576661),
                ),
                title: Text(
                  'Notificaciones',
                  style: GoogleFonts.alata(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF576661),
                      fontFamily: 'Alata',
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ],
          ),
          SizedBox(
            height: 400, // tamaño determinado del contenedor
            child: Column(
              children: [
                Expanded(
                  child:
                      Container(), // aquí iría el contenido que va en la parte superior de la pantalla
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
                      onTap: () {},
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
                      onTap: () {},
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