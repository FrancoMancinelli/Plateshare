import 'package:flutter/material.dart';
import 'package:plateshare/screens/InicioScreen.dart';
import 'package:plateshare/util/AppColors.dart';

class IngredientContainer extends StatefulWidget {
  const IngredientContainer({Key? key}) : super(key: key);

  @override
  _IngredientContainerState createState() => _IngredientContainerState();
}

class _IngredientContainerState extends State<IngredientContainer> {
  List<String> ingredients = [
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
    '· Carne picada - 500 Gramos',
  ];

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
                        border: Border.all(color: AppColors.blackColor, width: 2.5),
                      ),
                      child: InkWell(
                        onTap: () {},
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
                          child: const Center(
                            child: Text(
                              '2 Raciones',
                              style: TextStyle(
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
                        border: Border.all(color: AppColors.blackColor, width: 2.5),
                      ),
                      child: InkWell(
                        onTap: () {},
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
                children: ingredients.map((ingredient) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                    child: Text(
                      ingredient,
                      style: TextStyle(
                        color: AppColors.brownTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
