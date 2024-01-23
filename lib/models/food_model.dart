// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  int? id;
  String title;
  String body;
  List<String>? images;
  List<String>? ingredients;
  List<String>? recipe;
  NutritionFact? nutritionFact;
  int? authorId;
  DateTime? createdAt;
  bool? isPublic;
  List<Comment>? comments;
  List<dynamic>? categories;
  int? likersCount;
  bool? isFavourite;

  Food({
    this.id,
    required this.title,
    required this.body,
    this.images,
    this.ingredients,
    this.recipe,
    this.nutritionFact,
    this.authorId,
    this.createdAt,
     this.isPublic,
    this.comments,
    this.categories,
    this.likersCount,
    this.isFavourite,
    
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        images: List<String>.from(json["images"].map((x) => x)),
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        recipe: List<String>.from(json["recipe"].map((x) => x)),
        nutritionFact: NutritionFact.fromJson(json["nutrition_fact"]),
        authorId: json["authorId"],
        createdAt: DateTime.parse(json["createdAt"]),
        isPublic: json["isPublic"],
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        categories: json["categories"] == null ? null : List<dynamic>.from(json["categories"].map((x) => x)) ,
        likersCount: json["likers_count"],
        isFavourite: json["isFavourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
        "recipe": List<dynamic>.from(recipe!.map((x) => x)),
        "nutrition_fact": nutritionFact?.toJson(),
        "authorId": authorId,
        "createdAt": createdAt?.toIso8601String(),
        "isPublic": isPublic,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "likers_count": likersCount,
        "isFavourite": isFavourite,
      };
}

class NutritionFact {
  String? sugar;
  String? sodium;
  String? protein;
  String? calories;
  String? totalFat;
  String? cholesterol;
  String? servingSize;
  String? dietaryFiber;
  String? saturatedFat;
  String? totalCarbohydrate;
  

  NutritionFact({
    this.sugar,
    this.sodium,
    this.protein,
    this.calories,
    this.totalFat,
    this.cholesterol,
    this.servingSize,
    this.dietaryFiber,
    this.saturatedFat,
    this.totalCarbohydrate,
  });

  static String _parseCalories(dynamic calories) {
    if (calories is int || calories is double ) {
      // If calories is an integer, convert it to a string
      return calories.toString();
    } else if (calories is String) {
      // If calories is already a string, use it as is
      return calories;
    } else {
      // Handle other cases, e.g., null or unexpected types
      return ''; // Provide a default value or handle it according to your needs
    }
  }

  factory NutritionFact.fromJson(Map<String, dynamic> json) => NutritionFact(
        sugar: _parseCalories(json["sugar"]),
        sodium: _parseCalories(json["sodium"]),
        protein: _parseCalories(json["protein"]),
        calories: _parseCalories(json["calories"]),
        totalFat: _parseCalories(json["total_fat"]),
        cholesterol: _parseCalories(json["cholesterol"]),
        servingSize: _parseCalories(json["serving_size"]),
        dietaryFiber: _parseCalories(json["dietary_fiber"]),
        saturatedFat: _parseCalories(json["saturated_fat"]),
        totalCarbohydrate: _parseCalories(json["total_carbohydrate"]),
      );

  Map<String, dynamic> toJson() => {
        "sugar": sugar,
        "sodium": sodium,
        "protein": protein,
        "calories": calories,
        "total_fat": totalFat,
        "cholesterol": cholesterol,
        "serving_size": servingSize,
        "dietary_fiber": dietaryFiber,
        "saturated_fat": saturatedFat,
        "total_carbohydrate": totalCarbohydrate,
      };
}
class Comment {
    int? id;
    String body;
    int authorId;
    DateTime? createdAt;
    int? foodId;

    Comment({
        this.id,
        required this.body,
        required this.authorId,
        this.createdAt,
        this.foodId,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        authorId: json["authorId"],
        createdAt: DateTime.parse(json["createdAt"]),
        foodId: json["foodId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "authorId": authorId,
        "createdAt": createdAt?.toIso8601String(),
        "foodId": foodId,
    };
}