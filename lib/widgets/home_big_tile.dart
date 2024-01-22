import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/pages/food_list_details_page.dart';
import 'package:fooderapp/utils/helpers.dart';

class HomeBigTile extends StatelessWidget {
  final FoodList foodList;
  const HomeBigTile(this.foodList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FoodListDetailsPage(id: foodList.id))),
      child: SizedBox(
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 150,
              height: 150,
              child: Image.network(foodList.imageUrl),
            ),
            const VerticalSpacer(height: 10),
            Text(
              foodList.title,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey[500],
              ),
            )
          ],
        ),
      ),
    );
  }
}
