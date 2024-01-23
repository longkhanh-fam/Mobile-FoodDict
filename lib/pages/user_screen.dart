import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/services/profile_service.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/food_list_tile.dart';
import 'package:fooderapp/widgets/food_title.dart'; // Import your User class

class UserScreen extends StatefulWidget {
  final int id;
  const UserScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: getUserProfile(widget.id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator
              } else if (snapshot.hasError) {
                // Handle error state
                return Text('Error: ${snapshot.error}');
              } else {
                User user = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            user.imageUrl ?? defaultProfileImageUrl,
                            height: 150.0,
                            width: 150.0,
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,
                                style: const TextStyle(fontSize: 20)),
                            Row(
                              children: [
                                Text("${user.followers} followers"),
                                const SizedBox(width: 10),
                                Text("${user.following} following"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(user.bio,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("${user.name}'s list",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                          height: 200,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: user.foodLists.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const HorizontalSpacer(width: 20),
                            itemBuilder: (context, index) =>
                                FoodListTile(user.foodLists[index]),
                          )),
                    ),
                    Text("${user.name}'s foods",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                        height: 300,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: user.foods.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const HorizontalSpacer(width: 20),
                            itemBuilder: (context, index) {
                              final food = user.foods[index];
                              return FoodTile(
                                  food.id, food.title, food.images, food.body);
                            }))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
