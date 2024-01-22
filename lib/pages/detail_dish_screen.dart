import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:fooderapp/theme/font_theme.dart';
import 'package:fooderapp/utils/helpers.dart';
import 'package:fooderapp/widgets/nutrition_fact_card.dart';
import 'package:fooderapp/widgets/recipe_card.dart';

Map<String, dynamic> dish =

{
    "id": 4,
    "title": "Banh xeo`",
    "body": "Morem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. ",
    "imageUrl": 
      "https://images.unsplash.com/photo-1575936123452-b67c3203c357"
    ,
    "ingredients": [
      "1 rack of baby back ribs",
      "1 cup of BBQ sauce",
      "2 cloves of minced garlic",
      "1 tsp of paprika",
      "1 tsp of salt",
      "1 tsp of black pepper"
    ],
    "recipe": [
      "Cut the hard-boiled eggs in half lengthwise and remove the yolks.",
      "Place the yolks in a bowl and mash them with a fork.",
      "Add in mayonnaise, mustard, apple cider vinegar, salt, and pepper. Mix well.",
      "Scoop the yolk mixture into the egg white halves.",
      "Sprinkle with paprika for garnish.",
      "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
      "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
                  "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
                  "Cut the hard-boiled eggs in half lengthwise and remove the yolks.",
      "Place the yolks in a bowl and mash them with a fork.",
      "Add in mayonnaise, mustard, apple cider vinegar, salt, and pepper. Mix well.",
      "Scoop the yolk mixture into the egg white halves.",
      "Sprinkle with paprika for garnish.",
      "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
      "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
                  "Chill in the fridge for at least 30 minutes before serving.",
            "Sprinkle with paprika for garnish.",
      
    ],
    "nutrition_fact": {
      "Fat": "21g",
      "Fiber": "1g",
      "Sugar": "13g",
      "Sodium": "599mg",
      "Protein": "20g",
      "Calories": "343",
      "Cholesterol": "74mg",
      "Carbohydrate": "16g",
      "Saturated Fat": "6g"
    },
    "authorId": 1,
    "createdAt": "2024-01-20T06:06:50.349Z",
    "color": const Color(0xFF372A46),
    "playerColor": const Color(0xFFBD94ED),
    "playerColor2": const Color.fromARGB(255, 151, 127, 180),
  };

class DetailsDishScreen extends StatefulWidget {
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
  }) : super(key: key);
  final VoidCallback closeOpen;




  @override
  State<DetailsDish> createState() => _DetailsDishState();
}
class _DetailsDishState extends State<DetailsDish> {
  bool isLiked = false;
  int currentCardIndex = 0; // Track the index of the current card
  
  // List of different RecipeCard widgets
    List cardContentsList = [
      RecipeCard(title: 'Ingredients', recipe: dish['ingredients'] ?? []  ),
      RecipeCard(title: 'Recipe', recipe: dish['recipe'] ?? []  ),
      NutritionFactCard(nutritionFacts: dish['nutrition_fact'])


  ];


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
            dish["playerColor2"],
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
              widget.closeOpen();
            },
            icon: const Icon(FluentIcons.chevron_down_20_regular),
          ),
          title: Text(
            dish['title'],
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
            Expanded( // Changed from Flexible to Expanded
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    dish['imageUrl'],
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust the alignment as needed
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

            // Display cards based on the current index
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: currentCardIndex < cardContentsList.length
                    ? SingleChildScrollView( // Keep SingleChildScrollView if you have other widgets to scroll with the list
                        child: Column(
                          children: [
                            // If cardContentsList[currentCardIndex] returns a widget that uses ListView.builder internally:
                            cardContentsList[currentCardIndex] ?? Container(),
                            // Other widgets can go here and will scroll with the list
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
