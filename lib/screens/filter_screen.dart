import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/filter_provider.dart';
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
      ),
      body:
          //  WillPopScope(
          //   onWillPop: () async {
          //     // ref.read(filterProvider.notifier).setFilters({
          //     //   Filter.gluttenFree: _gluttenFilterSet,
          //     //   Filter.lactoseFree: _lactoseFilterSet,
          //     //   Filter.vegetarianFree: _vegetarianFilterSet,
          //     //   Filter.veganFree: _veganFilterSet
          //     // });
          //     return true;
          //   },
          //   child:
          Column(children: [
        SwitchListTile(
          value: mealFilters[Filter.gluttenFree]!,
          onChanged: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setFilter(Filter.gluttenFree, isChecked);
          },
          title: Text(
            "Glutten free",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            "Only include glutten free meals",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: mealFilters[Filter.lactoseFree]!,
          onChanged: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setFilter(Filter.lactoseFree, isChecked);
          },
          title: Text(
            "Lactose free",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            "Only include lactose free meals",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: mealFilters[Filter.vegetarianFree]!,
          onChanged: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setFilter(Filter.vegetarianFree, isChecked);
          },
          title: Text(
            "Vegetarian free",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            "Only include vegetarian free meals",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: EdgeInsets.only(left: 34, right: 22),
        ),
        SwitchListTile(
          value: mealFilters[Filter.veganFree]!,
          onChanged: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setFilter(Filter.veganFree, isChecked);
          },
          title: Text(
            "Vegan free",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          subtitle: Text(
            "Only include vegan free meals",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          activeColor: Theme.of(context).colorScheme.tertiary,
          contentPadding: EdgeInsets.only(left: 34, right: 22),
        )
      ]),
    );
  }
}
