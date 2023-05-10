import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateshare/models/User.dart';
import 'package:plateshare/pages/NotificationsPage.dart';
import 'package:plateshare/pages/ProfilePage.dart';
import 'package:plateshare/pages/RecepiesPage.dart';
import 'package:plateshare/screens/AddRecepieScreen.dart';
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

class _InicioScreenState extends State<InicioScreen> {
  final items = <Widget>[
    const Icon(Icons.notifications, size: 30),
    const Icon(Icons.home, size: 30),
    const Icon(Icons.person, size: 30),
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
        //El AppBar y Drawer solo se muestran si la pagina es la de recetas
        appBar: _selectedIndex == 1 ? MyAppBar() : null,
        drawer: _selectedIndex == 1 ? MyDrawer(
                nameData: widget.nameData,
                usernameData: widget.usernameData,
                profilePicData: widget.profilePicData,
              )
            : null,
        body: SingleChildScrollView(
          child: _getPage(_selectedIndex),
        ),
        floatingActionButton: _selectedIndex == 1 ? FloatingActionButton(
        backgroundColor: AppColors.orangeColor,
        child: Icon(Icons.add, size: 30,),
        onPressed: () {
          // Navigate to the screen where you want to add a recipe
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecepieScreen(emailData: widget.emailData, nameData: widget.nameData, profilePicData: widget.profilePicData, usernameData: widget.usernameData),
            ),
          );
        },
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(iconTheme: const IconThemeData(color: AppColors.whiteColor)),
          child: CurvedNavigationBar(
            color: AppColors.primaryColor,
            backgroundColor: Color.fromARGB(255, 16, 141, 99),
            buttonBackgroundColor: AppColors.orangeColor,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 500),
            items: items,
            height: 60,
            index: _selectedIndex,
            onTap: (_selectedIndex) => setState(() => this._selectedIndex = _selectedIndex),
          ),
        ),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const NotificationsPage();
      case 1: // Recetas | Home
        return const RecepiesPage();
      case 2:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
