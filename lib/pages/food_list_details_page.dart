import 'package:flutter/material.dart';
import 'package:fooderapp/config/colors/colors.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/services/food_list_service.dart';
import 'package:fooderapp/utils/food_list_builder.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/food_title.dart';
import 'package:fooderapp/widgets/user_widget.dart';

class FoodListDetailsPage extends StatefulWidget {
  final int id;
  const FoodListDetailsPage({super.key, required this.id});

  @override
  State<FoodListDetailsPage> createState() => _FoodListDetailsPageState();
}

class _FoodListDetailsPageState extends State<FoodListDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: getFoodList(widget.id),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  FoodList foodList = snapshot.data;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Album cover
                              Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.greenAccent.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0.5, 0.5),
                                      ),
                                    ],
                                  ),
                                  height: 300,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      foodList.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              UserWidget(foodList.author!),
                              // Album name
                              Text(
                                foodList.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 30),
                              ),
                              Text(
                                foodList.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 13,
                                    color: greyColor),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                          onPressed: () async {
                                            await favoriteFoodList(widget.id,
                                                !foodList.isFavourite);
                                            setState(() {});
                                          },
                                          icon: foodList.isFavourite
                                              ? favouriteIcon
                                              : unfavouriteIcon),
                                    ],
                                  )
                                ],
                              ),
                              const VerticalSpacer(height: 5),
                              ListView.separated(
                                primary: false,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final food = foodList.foods![index];
                                  return FoodTile(food.id, food.title,
                                      food.images, food.body);
                                },
                                itemCount: foodList.foods!.length,
                                separatorBuilder: (_, __) =>
                                    const VerticalSpacer(height: 10),
                              ),

                              const VerticalSpacer(height: 10),
                              // Album footer
                              const Text(
                                "You might also like",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const VerticalSpacer(height: 8),
                              SizedBox(
                                height: 200,
                                child: foodListBuilder(getFoodLists()),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
              })),
    );
  }
}
