import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/base_service.dart';

const foodController = "foods";

Future<void> commentFood(int id, String body) async {
  await BaseService().post("$foodController/$id/comment", {"body": body});
}

Future<void> favoriteFoodList(int id, bool isFavourite) async {
  await BaseService().post("$foodController/$id/like", {"value": isFavourite});
}

Future<Food> getFood(int id) async {
  debugPrint("getFood");
  return Food.fromJson(await BaseService().get("$foodController/$id"));
}

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
Future<List<Food>> getSomeFoods(int amount) async {
  return (await BaseService().getList("$foodController?take=$amount"))
      .map((e) => Food.fromJson(e))
      .toList();
}

Future<void> postFood( Map<String, dynamic>  food) async {
// Assuming you have a toJson method in your Food model
  const String endpoint = foodController; // Adjust the endpoint as needed

  try {
    await BaseService().post(endpoint, food);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during POST request: $e',
    );
  }
}

Future<void> updateFood( Map<String, dynamic>  food, int id) async {
// Assuming you have a toJson method in your Food model
  final String endpoint = "$foodController/$id"; // Adjust the endpoint as needed

  try {
    await BaseService().patch(endpoint, food);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during PATCH request: $e',
    );
  }
}

Future<void> deleteFood(int id) async {
// Assuming you have a toJson method in your Food model
  final String endpoint = "$foodController/$id"; // Adjust the endpoint as needed

  try {
    await BaseService().delete(endpoint);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during DELETE request: $e',
    );
  }
}
