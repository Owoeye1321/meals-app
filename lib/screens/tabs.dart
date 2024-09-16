import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../model/meal.dart';

const kInitializedFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  void selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> favouriteMeals = [];
  Map<Filter, bool> filterMeals = kInitializedFilters;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _addOrRemoveFavourites(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      setState(() {
        favouriteMeals.remove(meal);
        _showMessage("Meals removed successfully");
      });
    } else {
      setState(() {
        favouriteMeals.add(meal);
        _showMessage("Meals added successfully");
      });
    }
  }

  void _onSetScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                  currentFilters: filterMeals ?? kInitializedFilters)));
      setState(() {
        filterMeals = result ?? kInitializedFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (filterMeals[Filter.gluttenFree]! && !meal.isGlutenFree) return false;
      if (filterMeals[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (filterMeals[Filter.veganFree]! && !meal.isVegan) return false;
      if (filterMeals[Filter.vegetarianFree]! && !meal.isVegetarian)
        return false;
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      addOrRemoveFavourites: _addOrRemoveFavourites,
      availableMeals: availableMeals,
    );
    String activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: favouriteMeals,
        addOrRemoveFavourites: _addOrRemoveFavourites,
      );
      activePageTitle = "Favourites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          activePageTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      drawer: MainDrawer(
        onSelectScreen: _onSetScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) => {selectPage(index)},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
