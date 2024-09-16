import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/favourite_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import '../provider/filter_provider.dart';

const kInitializedFilters = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSetScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      availableMeals: ref.watch(filteredMealsProvider),
    );
    String activePageTitle = "Categories";
    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteProvider);
      activePage = MealScreen(
        meals: favouriteMeals,
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
