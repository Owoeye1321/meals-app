import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  final List<Category> categories = availableCategories;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Pick your category"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: categories
            .map(
              (category) => CategoryGridItem(category),
            )
            .toList(),
      ),
    );
  }
}
