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
            fillColor: AppColors.whiteColor,
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            prefixIcon: const Icon(Icons.search_outlined, color: AppColors.blackColor),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.filter_list_outlined),
        ),
      ],
    );
  }
}
