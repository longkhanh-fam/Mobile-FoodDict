import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/food_list_tile.dart';

Widget foodListBuilder(Future<List<FoodList>> fetch) {
  return FutureBuilder(
    future: fetch,
    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Show loading indicator
      } else if (snapshot.hasError) {
        // Handle error state
        return Text('Error: ${snapshot.error}');
      } else {
        List<FoodList> foodList = snapshot.data;
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: foodList.length,
          separatorBuilder: (BuildContext context, int index) =>
              const HorizontalSpacer(width: 20),
          itemBuilder: (context, index) => FoodListTile(foodList[index]),
        );
      }
    },
  );
}
