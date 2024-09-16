import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/meal.dart';

final mealProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
