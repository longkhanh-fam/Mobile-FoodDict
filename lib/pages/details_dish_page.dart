import 'package:flutter/material.dart';

class DetailsDishPage extends StatelessWidget {
  const DetailsDishPage({super.key});

  Widget buildSection(String title, List<String> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        const Divider(thickness: 5.0),
        Text(
          '$title:',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: data.length * 2 - 1,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return const Divider(height: 8.0, thickness: 2.0);
            } else {
              final itemIndex = index ~/ 2;
              return Text(
                data[itemIndex],
                style: const TextStyle(fontSize: 16.0),
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildNutritionSection(Map<String, String> nutritionData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        const Divider(thickness: 5.0),
        const Text(
          'Thành phần dinh dưỡng:',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: nutritionData.length * 2 - 1,
          itemBuilder: (context, index) {
            if (index.isOdd) {
              return const Divider(height: 8.0, thickness: 2.0);
            } else {
              final keyIndex = index ~/ 2;
              final key = nutritionData.keys.toList()[keyIndex];
              final value = nutritionData[key];
              return Row(
                children: [
                  Text(
                    '$key:',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' ${value!}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Giả sử bạn có một số dữ liệu món ăn như sau:
    String dishName = "Phở Bò";
    String imagePath = "assets/images/savagelevel.jpg";
    final List<String> ingredients = [
      "6-8 apples",
      "1/2 cup sugar",
      "1 tsp cinnamond",
      "1/4 tsp nutmeg",
      "1/4 tsp allspice",
      "1/4 tsp salt",
      "2 tbsp butter",
      "1 9-inch pie crust"
    ];
    final List<String> recipe = [
      "1. Preheat the oven to 375 degrees F.",
      "2. Peel and slice the apples, then mix them with the",
      "3. Roll out the pie crust and place it in a 9-inch pi",
      "4. Fill the pie crust with the apple mixture and dot",
      "5. Roll out another pie crust and place it on top of",
      "6. Cut a few slits in the top crust for ventilation.",
      "7. Bake for 45-50 minutes, until the crust is golden",
      "8. Let cool before serving."
    ];
    final Map<String, String> nutritionFacts = {
      "serving size": "1 slice (1/8 pie)",
      "calories": "296",
      "total fat": "12g",
      "saturated fat": "5g",
      "cholesterol": "8mg",
      "sodium": "259mg",
      "total carbohydrates": "47g",
      "dietary fiber": "3g",
      "sugars": "25g",
      "protein": "2g"
    };

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hình ảnh món ăn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset(imagePath),
                ),
              ],
            ),

            // Tên món ăn
            const SizedBox(height: 16.0),
            Text(
              dishName,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),

            buildSection('Nguyên liệu', ingredients),

            buildSection('Cách nấu', recipe),

            buildNutritionSection(nutritionFacts),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Icon(Icons.thumb_up),
                  onPressed: () {/* Like action */},
                ),
                TextButton(
                  child: const Icon(Icons.comment),
                  onPressed: () {/* Comment action */},
                ),
                TextButton(
                  child: const Icon(Icons.share),
                  onPressed: () {/* Share action */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
