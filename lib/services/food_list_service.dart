import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/services/base_service.dart';

const foodListController = "food-list";

Future<List<FoodList>> getFoodLists() async {
  return (await BaseService.instance.getList(foodListController))
      .map((e) => FoodList.fromJson(e))
      .toList();
}

Future<List<FoodList>> getFavouriteFoodLists() async {
  return (await BaseService.instance.getList("$foodListController/favourites"))
      .map((e) => FoodList.fromJson(e))
      .toList();
}

Future<FoodList> getFoodList(int id) async {
  return FoodList.fromJson(
      await BaseService.instance.get("$foodListController/$id"));
}

Future<void> favoriteFoodList(int id, bool isFavourite) async {
  await BaseService.instance
      .post("$foodListController/$id/like", {"value": isFavourite});
}
