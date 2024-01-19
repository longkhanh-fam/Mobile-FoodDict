import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/services/base_service.dart';

const profileController = "profile";

Future<User> getProfile() async {
  return User.fromJson(await BaseService().get(profileController));
}

Future<void> updateProfile(Map<String,dynamic> data) async {
  await BaseService().patch(profileController, data);
}