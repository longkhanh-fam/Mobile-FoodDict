import 'package:shared_preferences/shared_preferences.dart';

Future<int?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt("userId");
}
