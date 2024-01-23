
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/base_service.dart';

const foodController = "foods";

Future<List<Food>> getFoods() async {
  return (await BaseService().getList(foodController))
      .map((e) => Food.fromJson(e))
      .toList();
}

Future<List<Food>> getFavouriteFoods() async {
  return (await BaseService().getList("$foodController/favourites"))
      .map((e) => Food.fromJson(e))
      .toList();
}