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
    bool? isFavourite;
    List<FoodListFood> foods;

    FoodList({
        required this.id,
        required this.title,
        required this.description,
        required this.imageUrl,
        required this.authorId,
        this.isFavourite,
        required this.foods,
    });

    factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        authorId: json["authorId"],
        isFavourite: json["isFavourite"],
        foods: List<FoodListFood>.from(json["foods"].map((x) => FoodListFood.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "authorId": authorId,
        "isFavourite": isFavourite,
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
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
