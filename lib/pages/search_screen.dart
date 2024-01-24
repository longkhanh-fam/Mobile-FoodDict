import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/utils/helpers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  late Future<List<Food>> _foodList;
  @override
  void initState() {
    super.initState();
    // Fetching the list of foods when the widget is initialized
      _foodList = getFoods();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    isSearching = value.isNotEmpty;
                  });
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.black, size: 28.0),
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Find your recipe",
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 30, 15, 0),
            //   child: Text(
            //     isSearching ? 'Search Results' : 'Genres',
            //     style: const TextStyle(
            //       fontSize: 20.0,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            // Visibility(
            //   visible: !isSearching,
            //   child: Expanded(
            //     child: GenreGridView(),
            //   ),
            // ),
            Visibility(
              visible: isSearching,
              child: Expanded(
                child: Column(
                  children: [
                    // The new row to be displayed above the search results
                  //   Row(
                  //   children: <Widget>[
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Colors.grey[800],
                  //       ),
                  //       padding: const EdgeInsets.all(12),
                  //       child: const Text(
                  //         'Music',
                  //         style: TextStyle(
                  //             fontSize: 15, fontWeight: FontWeight.w400),
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
                  //         style: TextStyle(
                  //             fontSize: 15, fontWeight: FontWeight.w400),
                  //       ),
                  //     )
                  //   ],
                  // ),
                Expanded(
                  child: FutureBuilder<List<Food>>(
                    future: _foodList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!isSearching || snapshot.data!.isEmpty ?? true) {
                        return const SizedBox(); // Don't display anything when not searching or no results
                      } else {
                        // Filter foods based on the search query
                        final List<Food> searchResults = snapshot.data!
                            .where((food) => food.title.toLowerCase().contains(_searchController.text.toLowerCase()))
                            .toList();

                        if (searchResults.isEmpty) {
                          return const Text('No search results');
                        }

                        // Display the scrollable search results using ListView.builder
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final searchedFood = searchResults[index]; // Corrected line
                            return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsDishScreen(searchedFood.id!),
                                      ),
                                    );
                                  },
                                child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              horizontalTitleGap: 0,
                              leading: Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: SizedBox(
                                    width: 100, // Specify the width as per your requirement
                                    height: 100, // Specify the height as per your requirement
                                    child: Image.network(
                                      searchedFood.images![0], // Assuming images is a List<String> property in Food
                                      fit: BoxFit.cover, 
                                      // Adjust the fit property as needed
                                    ),
                                  ),
                                  
                                ),
                              ),
                              title: Text(
                                searchedFood.title, // Assuming title is a property in Food
                                style: const TextStyle(fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    searchedFood.isFavourite ?? false
                                        ? Icon(
                                            FluentIcons.heart_20_filled,
                                            color: Colors.greenAccent[400],
                                            size: 20,
                                          )
                                        : const SizedBox(),
                                    IconButton(
                                      icon: const Icon(FluentIcons.more_vertical_20_regular),
                                      padding: const EdgeInsets.only(left: 20, top: 5),
                                      iconSize: 26,
                                      onPressed: () {
                                        // Handle onPressed for the more options button
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          },
                          itemCount: searchResults.length,
                        );

                      }
                    },
                  ),
                ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
