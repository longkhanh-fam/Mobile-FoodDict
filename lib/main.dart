
import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/pages/news_feed_page.dart';
import 'package:fooderapp/pages/newsfeed_screen.dart';
import 'package:fooderapp/routes/route_generator.dart';
import 'package:fooderapp/theme/theme_data.dart';

void main() {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return MaterialApp(
      theme: darkTheme,
      initialRoute: homePage,
      onGenerateRoute: RouteGenerator.generatorRoute,
    //  home: NewsFeedScreen(),
    );
  }
}

