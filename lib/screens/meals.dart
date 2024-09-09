import 'package:flutter/material.dart';
import 'package:meals/model/meal.dart';

class MealScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;
  const MealScreen(this.title, this.meals, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (cxt, index) => Text(meals[index].title),
    );
    if (meals.isEmpty) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Meal is empty"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Try selecting another meal",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          )
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }
}
