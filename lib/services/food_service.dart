import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fooderapp/models/food_model.dart';
import 'package:fooderapp/services/base_service.dart';

const foodController = "foods";

Future<void> commentFood(int id, String body) async {
  await BaseService.instance
      .post("$foodController/$id/comment", {"body": body});
}

Future<void> favoriteFoodList(int id, bool isFavourite) async {
  await BaseService.instance
      .post("$foodController/$id/like", {"value": isFavourite});
}

Future<Food> getFood(int id) async {
  debugPrint("getFood");
  return Food.fromJson(await BaseService.instance.get("$foodController/$id"));
}

Future<List<Food>> getFoods() async {
  return (await BaseService.instance.getList(foodController))
      .map((e) => Food.fromJson(e))
      .toList();
}

Future<List<Food>> getFavouriteFoods() async {
  return (await BaseService.instance.getList("$foodController/favourites"))
      .map((e) => Food.fromJson(e))
      .toList();
}

Future<List<Food>> getSomeFoods(int amount) async {
  return (await BaseService.instance.getList("$foodController?take=$amount"))
      .map((e) => Food.fromJson(e))
      .toList();
}

Future<void> postFood(Map<String, dynamic> food) async {
// Assuming you have a toJson method in your Food model
  const String endpoint = foodController; // Adjust the endpoint as needed

  try {
    await BaseService.instance.post(endpoint, food);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during POST request: $e',
    );
  }
}

Future<void> updateFood(Map<String, dynamic> food, int id) async {
// Assuming you have a toJson method in your Food model
  final String endpoint =
      "$foodController/$id"; // Adjust the endpoint as needed

  try {
    await BaseService.instance.patch(endpoint, food);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during PATCH request: $e',
    );
  }
}

Future<void> deleteFood(int id) async {
// Assuming you have a toJson method in your Food model
  final String endpoint =
      "$foodController/$id"; // Adjust the endpoint as needed

  try {
    await BaseService.instance.delete(endpoint);
  } catch (e) {
    throw DioException(
      requestOptions: RequestOptions(path: endpoint),
      error: 'Error during DELETE request: $e',
    );
  }
}
