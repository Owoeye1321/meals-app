import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';

import '../model/meal.dart';

enum Filter { gluttenFree, lactoseFree, vegetarianFree, veganFree }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.gluttenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarianFree: false,
          Filter.veganFree: false
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final List<Meal> meals = ref.watch(mealProvider);
  final filteredMeals = ref.watch(filterProvider);
  return meals.where((meal) {
    if (filteredMeals[Filter.gluttenFree]! && !meal.isGlutenFree) return false;
    if (filteredMeals[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    if (filteredMeals[Filter.veganFree]! && !meal.isVegan) return false;
    if (filteredMeals[Filter.vegetarianFree]! && !meal.isVegetarian)
      return false;
    return true;
  }).toList();
});
