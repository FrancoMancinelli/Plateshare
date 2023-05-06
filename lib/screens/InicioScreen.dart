import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/widgets/MyAppBar.dart';
import 'package:plateshare/widgets/MyDrawer.dart';

import '../util/AppColors.dart';
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

var screenSize;

final TextEditingController _searchController = TextEditingController();
String _searchErrorText = '';

class _InicioScreenState extends State<InicioScreen> {
  final items = <Widget>[
    Icon(Icons.add, size: 30),
    Icon(Icons.home, size: 30),
    Icon(Icons.person, size: 30),
  ];

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        //extendBody: true,
        backgroundColor: AppColors.accentColor,
        //El AppBar y Drawer solo se muestran si la pagina es la de recetas
        appBar: _selectedIndex == 1 ? MyAppBar() : null,
        drawer: _selectedIndex == 1
            ? MyDrawer(
                nameData: widget.nameData,
                usernameData: widget.usernameData,
                profilePicData: widget.profilePicData,
              )
            : null,
        body: SingleChildScrollView(
          child: _getPage(_selectedIndex),
        ),
        //https://www.youtube.com/watch?v=TX2x41h47fE&t=7s&ab_channel=HeyFlutter%E2%80%A4com
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: AppColors.whiteColor)),
          child: CurvedNavigationBar(
            color: AppColors.primaryColor,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: AppColors.orangeColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 500),
            items: items,
            height: 60,
            index: _selectedIndex,
            onTap: (_selectedIndex) =>
                setState(() => this._selectedIndex = _selectedIndex),
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text('Search'),
        );
      case 1:
        return Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: AppColors.accentColor,
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
                          color: AppColors.brownTextColor,
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
                          color: AppColors.brownTextColor,
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
                          color: AppColors.brownRecepieColor,
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
        );
      case 2:
        return const Center(
          child: Text('Add'),
        );
      default:
        return Container();
    }
  }
}
