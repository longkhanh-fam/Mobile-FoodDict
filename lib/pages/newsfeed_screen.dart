import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/add_food_screen.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/widgets/newsfeed_item.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}
class _NewsFeedScreenState extends State<NewsFeedScreen> {
  //late Future<List<Food>> _foodList;
late Future<List<Food>> _foodList;
  @override
  void initState() {
    super.initState();
    // Fetching the list of foods when the widget is initialized
    _foodList = getSomeFoods(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foodfeeds',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder<List<Food>>(
        future: _foodList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the ListView.builder once the data is available
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NewsFeedItem(food: snapshot.data![index]);
              },
            );
          }

        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFoodScreen(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

