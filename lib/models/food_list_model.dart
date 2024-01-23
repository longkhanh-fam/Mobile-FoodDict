// To parse this JSON data, do
//
//     final foodList = foodListFromJson(jsonString);

import 'dart:convert';

FoodList foodListFromJson(String str) => FoodList.fromJson(json.decode(str));

String foodListToJson(FoodList data) => json.encode(data.toJson());

class FoodList {
  int id;
  String title;
  String description;
  String imageUrl;
  int authorId;
  List<FoodListFood>? foods;
  Author? author;
  bool isFavourite;

  FoodList({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.authorId,
    this.foods,
    this.author,
    required this.isFavourite,
  });

  factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        authorId: json["authorId"],
        foods: json["foods"] != null
            ? List<FoodListFood>.from(
                json["foods"].map((x) => FoodListFood.fromJson(x)))
            : null,
        author: json["author"] != null ? Author.fromJson(json["author"]) : null,
        isFavourite: json["isFavourite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "authorId": authorId,
        "foods": foods != null
            ? List<dynamic>.from(foods!.map((x) => x.toJson()))
            : null,
        "author": author?.toJson(),
        "isFavourite": isFavourite,
      };
}

class Author {
  int id;
  String name;
  String imageUrl;
  int followers;
  int following;

  Author({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.followers,
    required this.following,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "followers": followers,
        "following": following,
      };
}

class FoodListFood {
  int id;
  String title;
  List<String> images;
  String body;

  FoodListFood({
    required this.id,
    required this.title,
    required this.images,
    required this.body,
  });

  factory FoodListFood.fromJson(Map<String, dynamic> json) => FoodListFood(
        id: json["id"],
        title: json["title"],
        images: List<String>.from(json["images"].map((x) => x)),
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "images": List<dynamic>.from(images.map((x) => x)),
        "body": body,
      };
}
