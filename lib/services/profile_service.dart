import 'package:fooderapp/models/user_model.dart';
import 'package:fooderapp/services/base_service.dart';

const profileController = "profile";

Future<User> getUserProfile(int id) async {
  return User.fromJson(
      await BaseService.instance.get("$profileController/$id"));
}

Future<User> getProfile() async {
  return User.fromJson(await BaseService.instance.get(profileController));
}

Future<void> updateProfile(Map<String, dynamic> data) async {
  await BaseService.instance.patch(profileController, data);
}

Future<void> follow(int targetId, bool follow) async {
  await BaseService.instance.post(
      "$profileController/follow", {"targetId": targetId, "follow": follow});
}
