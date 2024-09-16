import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  const CategoriesScreen({super.key, required this.availableMeals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onSelectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: filteredMeals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: availableCategories
            .map(
              (category) => CategoryGridItem(category, () {
                print("hello");
                onSelectCategory(context, category);
              }),
            )
            .toList(),
      ),
      builder: (context, child) =>
          // Padding(
          //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
          //   child: child,
          // ),
          SlideTransition(
        position: Tween(
          begin: Offset(0, 0.2),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        )),
        // _animationController.drive(
        //   Tween(
        //     begin: Offset(0, 0.3),
        //     end: Offset(0, 0),
        //   ),
        // ), //drive help convert numbers from 0 and 1 to an animation between two values
        child: child,
      ),
    );
  }
}
