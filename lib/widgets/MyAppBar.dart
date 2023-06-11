import 'package:flutter/material.dart';
import 'package:plateshare/util/AppColors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({
    Key? key,
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
    'Home',
    style: TextStyle(
      color: AppColors.whiteColor,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  centerTitle: true, // Add this line to center the title
  actions: [
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search_rounded),
    ),
  ],
);

  }
}
