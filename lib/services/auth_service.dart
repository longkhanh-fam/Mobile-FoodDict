import 'package:fooderapp/services/base_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const authConstroller = "auth";

// Future<String> authTest() async {
//   return await BaseService().post("$authConstroller/test");
// }

Future<void> auth(String? idToken, String fcmToken) async {
  final data = await BaseService.instance
      .post(authConstroller, {"idToken": idToken, "fcmToken": fcmToken});
  final accessToken = data['accessToken'];
  BaseService.instance.setJwtToken(accessToken);
  final a = await SharedPreferences.getInstance();
  a.setInt("userId", data["id"]);
}
