import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/model/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);
  void toggleMealFavouriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((eachMeal) => eachMeal.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favouriteProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});
