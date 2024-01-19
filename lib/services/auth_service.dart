import 'package:fooderapp/services/base_service.dart';

const authConstroller = "auth";

// Future<String> authTest() async {
//   return await BaseService().post("$authConstroller/test");
// }

Future<void> auth(String? idToken) async {
  final data = await BaseService().post(authConstroller, {"idToken": idToken});
  final accessToken = data['accessToken'];
  BaseService().setJwtToken(accessToken);
}
