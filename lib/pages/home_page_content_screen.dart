import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/services/food_list_service.dart';
import 'package:fooderapp/theme/font_theme.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/food_list_tile.dart';
import 'package:fooderapp/widgets/home_page_recent_tile.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Salutations and top navbar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                      15, 30, 15, 0), // Adjust the padding as needed
                  child: Text(
                    'What\'s up Bof',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      15, 30, 15, 0), // Adjust the padding as needed
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.notifications_outlined,
                        size: 30,
                      ),
                      const HorizontalSpacer(width: 15),
                      const Icon(
                        Icons.history_outlined,
                        size: 30,
                      ),
                      const HorizontalSpacer(width: 15),
                      IconButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed(profilePage),
                        icon: const Icon(Icons.settings_outlined),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const VerticalSpacer(height: 20),

            //1st capsules
            // Row(
            //   children: <Widget>[
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.grey[800],
            //       ),
            //       padding: const EdgeInsets.all(12),
            //       child: const Text(
            //         'Music',
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            //       ),
            //     ),
            //     const HorizontalSpacer(width: 10),
            //     Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         color: Colors.grey[800],
            //       ),
            //       padding: const EdgeInsets.all(12),
            //       child: const Text(
            //         'Podcasts & Shows',
            //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            //       ),
            //     )
            //   ],
            // ),

            const VerticalSpacer(height: 20),
            //Tiles
            const Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HomePageRecentTile(
                        imagePath: 'assets/images/emlBB.jpeg',
                        title: 'East Mpaka London'),
                    HomePageRecentTile(
                        imagePath: 'assets/images/wakadinaliVom.jpeg',
                        title: 'Victims of Madness'),
                  ],
                ),
                VerticalSpacer(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HomePageRecentTile(
                        imagePath: 'assets/images/lilmama.jpg',
                        title: 'Lil Mama'),
                    HomePageRecentTile(
                        imagePath: 'assets/images/khalidFs.png',
                        title: 'Free Spirit'),
                  ],
                ),
                VerticalSpacer(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HomePageRecentTile(
                        imagePath: 'assets/images/protojeSLT.jpg',
                        title: 'Search of Lost Time'),
                    HomePageRecentTile(
                        imagePath: 'assets/images/zoza.jpg', title: 'Zoza'),
                  ],
                ),
              ],
            ),
            const VerticalSpacer(height: 20),
            const Text('Jump back in', style: mediumTitle),
            const VerticalSpacer(height: 20),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: getFoodLists(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      itemBuilder: (context, index) =>
                          FoodListTile(foodList[index]),
                    );
                  }
                },
              ),
            ),
            const VerticalSpacer(height: 20),
            const Text('Made for you', style: mediumTitle),
            const VerticalSpacer(height: 20),
            SizedBox(
              height: 200,
              child: FutureBuilder(
                future: getFoodLists(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      itemBuilder: (context, index) =>
                          FoodListTile(foodList[index]),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
