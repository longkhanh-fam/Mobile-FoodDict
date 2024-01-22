import 'package:flutter/material.dart';
import 'package:fooderapp/config/colors/colors.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';
import 'package:fooderapp/utils/helpers.dart';

class FoodWidget extends StatelessWidget {
  final FoodListFood food;
  const FoodWidget(this.food, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (_) => DetailsDishScreen())),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.title,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    downloadIconSmall,
                    const HorizontalSpacer(width: 4),
                    Text(
                      'Savara',
                      style: TextStyle(color: greyColor),
                    ),
                  ],
                )
              ],
            ),
            moreIcon
          ],
        ),
      ),
    );
  }
}
