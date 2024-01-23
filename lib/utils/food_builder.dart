import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/food_title.dart';

Widget foodBuilder(Future<List<Food>> fetch) {
  return FutureBuilder(
    future: fetch,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Show loading indicator
      } else if (snapshot.hasError) {
        // Handle error state
        return Text('Error: ${snapshot.error}');
      } else {
        List<Food> foods = snapshot.data;
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final food = foods[index];
            return FoodTile(food.id, food.title, food.images!, food.body);
          },
          itemCount: foods.length,
          separatorBuilder: (_, __) => const VerticalSpacer(height: 10),
        );
      }
    },
  );
}
