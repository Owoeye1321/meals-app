import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/widgets/meal_Item.dart';

class MealScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;
  const MealScreen(this.title, this.meals, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Meal is empty!",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Try selecting another meal",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          )
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (cxt, index) => MealItem(meals[index]),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(title),
      ),
      body: content,
    );
  }
}
