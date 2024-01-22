import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/theme/font_theme.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/nutrition_fact_card.dart';
import 'package:fooderapp/widgets/recipe_card.dart';

import '../config/colors/colors.dart';


class DetailsDishScreen extends StatefulWidget {
  final Food dish;

  const DetailsDishScreen({required this.dish, Key? key}) : super(key: key);

  @override
  _DetailsDishScreenState createState() => _DetailsDishScreenState();
}

class _DetailsDishScreenState extends State<DetailsDishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailsDish(
              dish: widget.dish,
              closeOpen: () {
                // Add your closeOpen logic here
                // This is just a placeholder for the callback
              },
            ),
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
  bool isLiked = false;
  int currentCardIndex = 0;
  late Food dish; // Declare dish here

  // List of different RecipeCard widgets
  late List<dynamic> cardContentsList;

  @override
  void initState() {
    super.initState();
    // Initialize dish and cardContentsList in the initState method
    dish = widget.dish;
    cardContentsList = [
      RecipeCard(title: 'Ingredients', recipe: dish.ingredients ?? []),
      RecipeCard(title: 'Recipe', recipe: dish.recipe ?? []),
      NutritionFactCard(nutritionFacts: (dish.nutritionFact ?? NutritionFact()).toJson()),
    ];
  }
  List<String> formatNutritionFacts(Map<String, dynamic> nutritionFacts) {
    List<String> formattedFacts = [];
    nutritionFacts.forEach((key, value) {
      formattedFacts.add("$key: $value");
    });
    return formattedFacts;
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
            IconButton(
              onPressed: () {},
              icon: const Icon(FluentIcons.more_horizontal_20_regular),
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
                    icon: const Icon(FluentIcons.device_meeting_room_remote_20_regular),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(FluentIcons.share_ios_20_regular),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    icon: isLiked ? Icon(FluentIcons.heart_20_filled) : Icon(FluentIcons.heart_20_regular),
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
                  child: Text('Ingredients'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentCardIndex = 1;
                    });
                  },
                  child: Text('Recipe'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentCardIndex = 2;
                    });
                  },
                  child: Text('Nutrition Facts'),
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
