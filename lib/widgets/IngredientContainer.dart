import 'package:flutter/material.dart';
import 'package:plateshare/util/AppColors.dart';

import '../models/Ingredient.dart';

class IngredientContainer extends StatefulWidget {
  final int recipeRations;
  final List<Ingredient> recipeIngredients;

  const IngredientContainer(
      {Key? key, required this.recipeRations, required this.recipeIngredients})
      : super(key: key);

  @override
  _IngredientContainerState createState() => _IngredientContainerState();
}

class _IngredientContainerState extends State<IngredientContainer> {
  int _currentRations = 0;

  @override
  void initState() {
    super.initState();
    _currentRations = widget.recipeRations;
  }

  // Actualiza la candidad de raciones aumentandola en 1
  void _incrementRations() {
    setState(() {
      if (_currentRations < 50) {
        _currentRations++;
      }
    });
  }

  // Actualiza la candidad de raciones disminuyendola en 1
  void _decrementRations() {
    setState(() {
      if (_currentRations > 1) {
        _currentRations--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.blackColor, width: 2.5),
                      ),
                      child: InkWell(
                        onTap: _decrementRations,
                        child: const Icon(
                          Icons.expand_more_rounded,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: AppColors.brownInfoRecipe,
                          width: 100,
                          height: 35,
                          child: Center(
                            child: Text(
                              '$_currentRations Raciones',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.blackColor, width: 2.5),
                      ),
                      child: InkWell(
                        onTap: _incrementRations,
                        child: const Icon(
                          Icons.expand_less_rounded,
                          color: AppColors.blackColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.recipeIngredients.map((ingredient) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Text(
                      '· ${ingredient.name} - ${ingredient.amount * _currentRations} ${ingredient.type}',
                      style: const TextStyle(
                        color: AppColors.brownTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
