import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/widgets/MyDrawer.dart';

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
      drawer: MyDrawer(nameData: widget.nameData, usernameData: widget.usernameData, profilePicData: widget.profilePicData,),
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
