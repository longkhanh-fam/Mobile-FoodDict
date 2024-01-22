import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/config/constants.dart';
import 'package:fooderapp/firebase_options.dart';
import 'package:fooderapp/pages/login_page.dart';
import 'package:fooderapp/routes/route_generator.dart';
import 'package:fooderapp/theme/theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      initialRoute: FirebaseAuth.instance.currentUser == null ? loginPage:  homePage,
      onGenerateRoute: RouteGenerator.generatorRoute,
    );
  }
}

