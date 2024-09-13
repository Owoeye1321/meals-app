import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen();
    String activePageTitle = "Categories";
    if (_selectedPageIndex == 2) {
      activePage = MealScreen("Favourites", []);
      String activePageTitle = "Favourites";
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
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {selectPage(index)},
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites")
        ],
      ),
    );
  }
}
