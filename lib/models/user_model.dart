import 'dart:convert';

import 'package:fooderapp/models/food_list_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String name;
  String bio;
  String? imageUrl;
  List<FoodListFood> foods;
  List<FoodList> foodLists;
  int followers;
  int following;

  User({
    required this.id,
    required this.name,
    required this.bio,
    this.imageUrl,
    required this.foods,
    required this.foodLists,
    required this.followers,
    required this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        bio: json["bio"],
        imageUrl: json["imageUrl"],
        foods: List<FoodListFood>.from(
            json["foods"].map((x) => FoodListFood.fromJson(x))),
        foodLists: List<FoodList>.from(
            json["foodLists"].map((x) => FoodList.fromJson(x))),
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "bio": bio,
        "imageUrl": imageUrl,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "foodLists": List<dynamic>.from(foodLists.map((x) => x.toJson())),
        "followers": followers,
        "following": following,
      };
}
