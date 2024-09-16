import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favourite_provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/meal.dart';

class MealDetails extends ConsumerWidget {
  final Meal meal;
  MealDetails({super.key, required this.meal});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void toggleFunction(Meal meal) {
      final result =
          ref.read(favouriteProvider.notifier).toggleMealFavouriteStatus(meal);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result
              ? "Favourite added successfully"
              : "Favourite removed successfully"),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () => {toggleFunction(meal)},
              icon: Icon(Icons.star),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ingridients",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              SizedBox(height: 21),
              Text(
                "Steps",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
        ));
  }
}
