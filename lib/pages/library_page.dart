import 'package:flutter/material.dart';
import 'package:fooderapp/services/food_list_service.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/utils/food_builder.dart';
import 'package:fooderapp/utils/food_list_builder.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Library',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Favourite list",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: 200, child: foodListBuilder(getFavouriteFoodLists())),
            ),
            const Text("Favourite foods",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: 200, child: foodBuilder(getFavouriteFoods())),
            ),
          ],
        ),
      ),
    );
  }
}
