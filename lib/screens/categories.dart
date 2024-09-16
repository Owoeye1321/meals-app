import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Category> categories = availableCategories;

  void onSelectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
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
    return Container(
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: categories
            .map(
              (category) => CategoryGridItem(category, () {
                print("hello");
                onSelectCategory(context, category);
              }),
            )
            .toList(),
      ),
    );
  }
}
