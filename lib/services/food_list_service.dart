import 'package:fooderapp/models/food_list_model.dart';
import 'package:fooderapp/services/base_service.dart';

const foodListController = "food-list";

Future<List<FoodList>> getFoodLists() async {
  return (await BaseService().getList(foodListController))
      .map((e) => FoodList.fromJson(e))
      .toList();
}
Future<List<FoodList>> getFavouriteFoodLists() async {
  return (await BaseService().getList("$foodListController/favourites"))
      .map((e) => FoodList.fromJson(e))
      .toList();
}

Future<FoodList> getFoodList(int id) async {
  return FoodList.fromJson(await BaseService().get("$foodListController/$id"));
}

Future<void> favoriteFoodList(int id, bool isFavourite) async {
  await BaseService().post("$foodListController/$id/like", {"value": isFavourite});
}
