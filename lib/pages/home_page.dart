import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/pages/camera_screen.dart';
import 'package:fooderapp/pages/detail_dish_screen.dart';
import 'package:fooderapp/pages/edit_food_screen.dart';
import 'package:fooderapp/pages/home_page_content_screen.dart';
import 'package:fooderapp/pages/library_page.dart';
import 'package:fooderapp/pages/newsfeed_screen.dart';
import 'package:fooderapp/pages/search_screen.dart';
import 'package:fooderapp/pages/add_food_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentNavItem = 0;
// Food dish1 = Food(

//     id:  4,
//     title: "Banh xeo`",
//     body: "Morem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. ",
//     images: 
//       ["https://images.unsplash.com/photo-1575936123452-b67c3203c357"]
//     ,
//     ingredients: [
//       "1 rack of baby back ribs",
//       "1 cup of BBQ sauce",
//       "2 cloves of minced garlic",
//       "1 tsp of paprika",
//       "1 tsp of salt",
//       "1 tsp of black pepper"
//     ],
//     recipe: [
//       "Cut the hard-boiled eggs in half lengthwise and remove the yolks.",
//       "Place the yolks in a bowl and mash them with a fork.",
//       "Add in mayonnaise, mustard, apple cider vinegar, salt, and pepper. Mix well.",
//       "Scoop the yolk mixture into the egg white halves.",
//       "Sprinkle with paprika for garnish.",
//       "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
//       "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
//                   "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
//                   "Cut the hard-boiled eggs in half lengthwise and remove the yolks.",
//       "Place the yolks in a bowl and mash them with a fork.",
//       "Add in mayonnaise, mustard, apple cider vinegar, salt, and pepper. Mix well.",
//       "Scoop the yolk mixture into the egg white halves.",
//       "Sprinkle with paprika for garnish.",
//       "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
//       "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
//                   "Chill in the fridge for at least 30 minutes before serving.",
//             "Sprinkle with paprika for garnish.",
      
//     ],
//     nutritionFact: NutritionFact(
//       sugar: "21g",
//       sodium: "1g",
//       calories: "343",),
//     authorId: 1,
//     createdAt: DateTime.now(),
//   );
  final List<Widget> _screens = [
    const HomePageContent(),
    const NewsFeedScreen(),
    const CameraScreen(),
    const SearchScreen(),
    const LibraryPage()
    

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentNavItem,
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Foodfeeds',
              activeIcon: Icon(Icons.food_bank_outlined)),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance_rounded),
            label: 'Detect Food',
            activeIcon: Icon(Icons.library_music_rounded)),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              activeIcon: Icon(Icons.search_outlined)),

          BottomNavigationBarItem(
              icon: Icon(Icons.library_music_outlined),
              label: 'Library',
              activeIcon: Icon(Icons.library_music_rounded)),
        ],
        fixedColor: Colors.white,
        iconSize: 20,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (index) {
          setState(() {
            _currentNavItem = index;
          });
        },
      ),
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentNavItem,
        children: _screens,
      ),
    );
  }
}
