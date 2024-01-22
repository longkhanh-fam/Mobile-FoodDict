import 'package:flutter/material.dart';
import 'package:fooderapp/config/colors/colors.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/services/food_list_service.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/album_footer_widget.dart';
import 'package:fooderapp/widgets/food_widget.dart';

class FoodListDetailsPage extends StatefulWidget {
  final int id;
  const FoodListDetailsPage({super.key, required this.id});

  @override
  State<FoodListDetailsPage> createState() => _FoodListDetailsPageState();
}

class _FoodListDetailsPageState extends State<FoodListDetailsPage> {
  late Future<FoodList>? _future;
  bool _isFavourite = false;
  @override
  void initState() {
    super.initState();
    _future = getFoodList(widget.id);
  }

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
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  FoodList foodList = snapshot.data;
                  _isFavourite = foodList.isFavourite ?? false;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Album cover
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: Image.network(foodList.imageUrl),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                            await favoriteFoodList(
                                                widget.id, !_isFavourite);
                                            setState(() {
                                              _isFavourite = !_isFavourite;
                                            });
                                          },
                                          icon: _isFavourite
                                              ? favouriteIcon
                                              : unfavouriteIcon),
                                    ],
                                  )
                                ],
                              ),
                              const VerticalSpacer(height: 5),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    FoodWidget(foodList.foods[index]),
                                itemCount: foodList.foods.length,
                                separatorBuilder: (_, __) =>
                                    const VerticalSpacer(height: 10),
                              ),

                              const VerticalSpacer(height: 10),
                              // Album footer
                              const AlbumFooter()
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
