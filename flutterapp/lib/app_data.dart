import 'package:flutter/material.dart';

enum PresetColor {
  red, green, blue, yellow, purple
}
// Class representing an ingredient in the fridge
class IngredientData {
  String name;
  String quantity;
  int expiry;

  IngredientData({
    required this.name,
    required this.quantity,
    required this.expiry,
  });

  // Convert ingredient to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'expiry': expiry,
      };

  // Create ingredient from JSON
  factory IngredientData.fromJson(Map<String, dynamic> json) {
    return IngredientData(
      name: json['name'],
      quantity: json['quantity'],
      expiry: json['daysUntilExpiry'],
    );
  }
}

// Class representing a fridge
class FridgeData {
  String name;
  IconData icon;
  PresetColor color;
  double temperature;
  List<IngredientData> contents;

  FridgeData({
    required this.name,
    required this.icon,
    required this.color,
    required this.temperature,
    required this.contents,
  });

  // Convert fridge to JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon.codePoint,
        'iconFontFamily': icon.fontFamily,
        'color': color,
        'temperature': temperature,
        //'contents': contents.map((ingredient) => ingredient.toJson()).toList(),
      };

  // Create fridge from JSON
  factory FridgeData.fromJson(Map<String, dynamic> json) {
    return FridgeData(
      name: json['name'],
      icon: IconData(
        json['icon'],
        fontFamily: json['iconFontFamily'],
      ),
      color: json['color'],
      temperature: json['temperature'],
      contents: List<IngredientData>.from(
          json['contents'].map((x) => IngredientData.fromJson(x))),
    );
  }
}

class RecipeData {
  String name;
  double starRating;
  double difficultyRating;
  int servingSize;
  List<String> method;
  String? uploadImage;
  String? youtubeVid;
  String description;
  String? backdrop;
  int? peopleReviewed;
  List<List<dynamic>> ingredients;
  Map<String, dynamic>? allIngredients;

  RecipeData({
    required this.name,
    required this.starRating,
    required this.difficultyRating,
    required this.servingSize,
    required this.method,
    this.uploadImage,
    this.youtubeVid,
    required this.description,
    this.backdrop,
    this.peopleReviewed,
    required this.ingredients,
    this.allIngredients,
  });

  factory RecipeData.fromJson(Map<String, dynamic> json) {
    return RecipeData(
      name: json['name'],
      starRating: json['starRating'],
      difficultyRating: json['difficultyRating'],
      servingSize: json['servingSize'],
      method: List<String>.from(json['method']),
      //uploadImage: json['uploadImage'],
      //youtubeVid: json['youtubeVid'],
      description: json['description'],
      //backdrop: json['backdrop'],
      //peopleReviewed: json['peopleReviewed'],
      ingredients: List<List<dynamic>>.from(json['ingredients']),
      allIngredients: Map<String, dynamic>.from(json['allIngredients']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'starRating': starRating,
      'difficultyRating': difficultyRating,
      'servingSize': servingSize,
      'method': method,
      'uploadImage': uploadImage,
      'youtubeVid': youtubeVid,
      'description': description,
      'backdrop': backdrop,
      'peopleReviewed': peopleReviewed,
      'ingredients': ingredients,
      'allIngredients': allIngredients,
    };
  }
}