// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  int id;
  String title;
  String body;
  List<String>? images;
  List<String>? ingredients;
  List<String>? recipe;
  NutritionFact? nutritionFact;
  int? authorId;
  DateTime? createdAt;
  bool? isLiked;

  Food({
    required this.id,
    required this.title,
    required this.body,
    this.images,
    this.ingredients,
    this.recipe,
    this.nutritionFact,
    this.authorId,
    this.createdAt,
    this.isLiked
    
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
    if (calories is int) {
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
        sugar: json["sugar"],
        sodium: json["sodium"],
        protein: json["protein"],
        calories: _parseCalories(json["calories"]),
        totalFat: json["total_fat"],
        cholesterol: json["cholesterol"],
        servingSize: json["serving_size"],
        dietaryFiber: json["dietary_fiber"],
        saturatedFat: json["saturated_fat"],
        totalCarbohydrate: json["total_carbohydrate"],
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
