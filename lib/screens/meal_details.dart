import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/meal.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  MealDetails({super.key, required this.meal});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(meal.title),
        ),
        body: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
            ),
            SizedBox(
              height: 20,
            ),
            Text(meal.title)
          ],
        ));
  }
}
