import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../model/meal.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      addOrRemoveFavourites: _addOrRemoveFavourites,
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
      drawer: MainDrawer(),
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
