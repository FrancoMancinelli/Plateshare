import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';

import 'LoginScreen.dart';

class InicioScreen extends StatefulWidget {
  final String emailData;
  final String nameData;
  final String usernameData;
  final String profilePicData;

  const InicioScreen({
    Key? key,
    required this.emailData,
    required this.nameData,
    required this.usernameData,
    required this.profilePicData,
  }) : super(key: key);

  @override
  _InicioScreenState createState() => _InicioScreenState();
}


final TextEditingController _searchController = TextEditingController();
String _searchErrorText = '';

class _InicioScreenState extends State<InicioScreen> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF056C49),
        title: SizedBox(
          height: 30, // ajusta la altura
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide.none, // borra el borde
              ),
              labelText: 'Buscar...',
              errorText: _searchErrorText.isEmpty ? null : _searchErrorText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              prefixIcon:
                  const Icon(Icons.search_outlined, color: Colors.black),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list_outlined),
          ),
        ],
      ),
      drawer: Drawer(
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
                              widget.profilePicData,
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
                              widget.nameData,
                              style: GoogleFonts.acme(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'Acme',
                                ),
                              ),
                            ),
                           Text('@${widget.usernameData}',
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
                        onTap: () {Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: Color(0xFFF9EDDE),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Economicas',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF4F3119),
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                    child: Text(
                      'Ver más',
                      style: GoogleFonts.acme(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4F3119),
                          fontFamily: 'Acme',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: 215,
                        height: 250,
                        decoration: BoxDecoration(
                          color: const Color(0xFFCBB79F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [],
                        ),
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
