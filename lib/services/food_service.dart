
import 'package:dio/dio.dart';
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


Future<void> postFood(Food food) async {
    final Map<String, dynamic> foodData = food.toJson(); // Assuming you have a toJson method in your Food model
    const String endpoint = foodController; // Adjust the endpoint as needed

    try {
       await BaseService().post(endpoint, foodData);
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: endpoint),
        error: 'Error during POST request: $e',
      );
    }
  }