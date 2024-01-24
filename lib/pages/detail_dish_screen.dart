import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/add_food_screen.dart';
import 'package:fooderapp/pages/edit_food_screen.dart';
import 'package:fooderapp/services/food_service.dart';
import 'package:fooderapp/widgets/comment_widget.dart';
import 'package:fooderapp/widgets/nutrition_fact_card.dart';
import 'package:fooderapp/widgets/recipe_card.dart';

import '../config/colors/colors.dart';

class DetailsDishScreen extends StatefulWidget {
  final int id;

  const DetailsDishScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<DetailsDishScreen> createState() => _DetailsDishScreenState();
}

class _DetailsDishScreenState extends State<DetailsDishScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: getFood(widget.id),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator
                } else if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                } else {
                  Food food = snapshot.data;
                  return DetailsDish(
                    dish: food,
                    closeOpen: () {
                      // Add your closeOpen logic here
                      // This is just a placeholder for the callback
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailsDish extends StatefulWidget {
  const DetailsDish({
    Key? key,
    required this.closeOpen,
    required this.dish,
  }) : super(key: key);

  final VoidCallback closeOpen;
  final Food dish;

  @override
  State<DetailsDish> createState() => _DetailsDishState();
}

class _DetailsDishState extends State<DetailsDish> {
  late bool isLiked;
  int currentCardIndex = 0;
  late Food dish; // Declare dish here

  // List of different RecipeCard widgets
  late List<dynamic> cardContentsList;

  @override
  void initState() {
    super.initState();
    // Initialize dish and cardContentsList in the initState method
    dish = widget.dish;
    isLiked = dish.isFavourite!;
    cardContentsList = [
      RecipeCard(title: 'Ingredients', recipe: dish.ingredients ?? []),
      RecipeCard(title: 'Recipe', recipe: dish.recipe ?? []),
      NutritionFactCard(
          nutritionFacts: (dish.nutritionFact ?? NutritionFact()).toJson()),
    ];
  }

  List<String> formatNutritionFacts(Map<String, dynamic> nutritionFacts) {
    List<String> formattedFacts = [];
    nutritionFacts.forEach((key, value) {
      formattedFacts.add("$key: $value");
    });
    return formattedFacts;
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Food'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to delete this food?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // Perform delete operation here
                  // Add your delete logic here
                    await deleteFood(widget.dish.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Food Deleted successfully'),
                    ),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));

                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
    }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [0.4, 1],
          colors: [
            playerColor2,
            Colors.black.withOpacity(0.00001),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(FluentIcons.arrow_left_24_regular),
          ),
          title: Text(
            widget.dish.title,
            style: const TextStyle(fontSize: 20, color: Colors.white70),
          ),
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
                // Add more items as needed
              ],
              onSelected: (value) {
                // Handle menu item selection
                if (value == 'delete') {
                   _showDeleteConfirmationDialog(context);
                } else if (value == 'edit') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFoodScreen(id: dish.id!),
                      ),
                    );
                  
                }
              },
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    widget.dish.images![0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                        FluentIcons.device_meeting_room_remote_20_regular),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isLiked = !isLiked;
                      });
                      await favoriteFoodList(dish.id!, !isLiked);
                    },
                    icon: isLiked
                        ? const Icon(FluentIcons.heart_20_filled)
                        : const Icon(FluentIcons.heart_20_regular),
                  ),
                  IconButton(
                    onPressed: () {
                      // Show the CommentWidget when the button is pressed
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CommentWidget(dish.id!, dish.comments!);
                        },
                      );
                    },
                    icon: const Icon(FluentIcons.comment_20_regular),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentCardIndex = 0;
                    });
                  },
                  child: const Text('Ingredients'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentCardIndex = 1;
                    });
                  },
                  child: const Text('Recipe'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentCardIndex = 2;
                    });
                  },
                  child: const Text('Nutrition Facts'),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: currentCardIndex < cardContentsList.length
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            cardContentsList[currentCardIndex] ?? Container(),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  
}
