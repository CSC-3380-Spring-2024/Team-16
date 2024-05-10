  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:foodappproject/quantity_converter.dart';
  import 'dart:typed_data';
  import 'package:http/http.dart' as http;

  enum PresetColor {
    red, green, blue, yellow, purple
  }
  // Class representing an ingredient in the fridge
  class IngredientData {
    String name;
    String quantity;
    int expiry;
    IngredientInfo? ingredientInfo;

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

    /* 
    * Returns a Quantity Struct object storing the separated amount and unit of a quantity
    * in double and String components, respectively. This object meant to be used temporarily
    * for computations such as subtractions.
    */
    QuantityStruct parseQuantity() {
      double amount = 0;
      RegExp pattern = RegExp(r"(\d+(?:\.\d+)?)"); // match one or more digits with optional decimal point
      RegExpMatch? match = pattern.firstMatch(quantity);
      if (match != null) {
        amount = double.parse(match.group(0)!);
      }

      String unit = "";
      RegExp strPattern = RegExp(r"[a-zA-Z]+"); // match one or more letters
      RegExpMatch? strMatch = strPattern.firstMatch(quantity);
      if (match != null) {
        unit = strMatch!.group(0)!;
      }
      return QuantityStruct(amount: amount, unit: unit);
    }

    /* 
    * Subtracts the given amount from the ingredient's quantity. Unit conversions are handled,
    * and the quantity maintains the units of the ingredientData's quantity attribute.
    */
    
    void subtractQuantity(QuantityStruct neg) {
      QuantityStruct curqn = parseQuantity();
      String originalUnit = curqn.unit;
      bool liquid = ingredientInfo!.liquid;
      String generalUnit = liquid ? "ml" : "g";
      if (curqn.unit != generalUnit) {
        curqn.amount = liquid ? Quantity.volumeToMilliliter(curqn, this) : Quantity.dryToGram(curqn, this);
      }
      print("NEG");
      print(neg.unit);
      print(neg.amount);
      if (neg.unit != generalUnit) {
        neg.amount = liquid ? Quantity.volumeToMilliliter(neg, this) : Quantity.dryToGram(neg, this);
      }
      
      curqn.amount -= neg.amount;

      if (originalUnit != generalUnit) {
        curqn.amount = liquid ? Quantity.inverseVolumeToMilliliter(curqn.amount, originalUnit, ingredientInfo!) : Quantity.inverseDryToGram(curqn.amount, originalUnit, ingredientInfo!);
      }
      if (curqn.amount < 0) {
        AppData.openedFridge.contents.remove(this);
      }
      String temp = curqn.amount.toStringAsFixed(2);
      curqn.amount = double.parse(temp);
      this.quantity = '${curqn.amount} ${curqn.unit}';
    }

    Future<IngredientInfo> fetchIngredientInfo() async {
      if (ingredientInfo != null) {return ingredientInfo!;}
      
      final response = await http.get(Uri.parse('http://localhost:8080/ingredient/$name'));
      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        print("I AM ABOUT TO.");
        print(response.body);
        IngredientInfo data = IngredientInfo.fromJson(jsonDecode(response.body));
        print(data);
        // Assuming the response is a list of strings, you may need to modify this depending on the actual response structure
        AppData.ingredientInfoCache.add(data);
        ingredientInfo = data;
        print(data.toString());
        return data;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load ingredient info');
      }
    }

  }

  //Class which stores prudent data about an ingredient such as expiry, quantity per unit, etc.
  class IngredientInfo {
    String name;TextEditingController quantityController = TextEditingController();
    int shelfLife;
    double gramPerUnit;
    bool liquid;
    bool countable;
    int appropriateQuantity;

    IngredientInfo({
        required this.name,
        required this.shelfLife,
        required this.gramPerUnit,
        required this.liquid,
        required this.countable,
        required this.appropriateQuantity,
      });

    factory IngredientInfo.fromJson(Map<String, dynamic> json) {
      return IngredientInfo(
        name: json['name'],
        shelfLife: json['shelfLife'],
        gramPerUnit: json['gramPerUnit'],
        liquid: json['liquid'],
        countable: json['countable'],
        appropriateQuantity: json['appropriateQuantity'],
      );
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['name'] = this.name;
      data['shelfLife'] = this.shelfLife;
      data['gramPerUnit'] = this.gramPerUnit;
      data['liquid'] = this.liquid;
      data['isCountable'] = this.countable;
      data['appropriateQuantity'] = this.appropriateQuantity;
      return data;
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
    String? youtubeVid;
    String description;
    String? backdrop;
    int? peopleReviewed = 0;
    List<List<dynamic>> ingredients;
    Map<String, dynamic>? allIngredients;
    String? uploadImage;

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
        backdrop: json['backdrop'],
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

  class AppData {
    static String? currentUser;
    static List<RecipeData> favoriteRecipes = [];
    static RecipeData viewedRecipe = dummyRecipe;
    static bool isTrackingRecipe = false;
    static List<int> completedMethods = [];
    static List<int> completedIngredients = [];
    static List<IngredientInfo> ingredientInfoCache = []; // Stores a cache of ingredient info data fetched from the server to
                                                          // improve performance and reduce server load. This should probably
                                                          // be cleared every now and then... oh well.
    static FridgeData openedFridge = FridgeData(
      name: "My Pantry",
      icon: Icons.access_alarm_outlined,
      color: PresetColor.yellow,
      temperature: 69.8,
      contents: [IngredientData(name: "Banana", quantity: "1 qt", expiry: 4)],
      );
     static void addFavoriteRecipe(RecipeData recipe) {
    if (!favoriteRecipes.contains(recipe)) {
      favoriteRecipes.add(recipe);
    }
  }
    //static List<String> draftRecipe;

    /*
    * placeholder data used for quick hotloading n stuff
    */
    static RecipeData dummyRecipe = RecipeData(
      name: "Spaghetti Carbonara",
      starRating: 2.1,
      difficultyRating: 4.5,
      servingSize: 4,
      method: [
        "Boil water in a large pot.",
        "Cook spaghetti according to package instructions.",
        "In a skillet, cook pancetta until crispy.",
        "Whisk together eggs, cheese, and black pepper.",
        "Drain spaghetti and toss with egg mixture.",
        "Add pancetta and mix well. Serve hot."
      ],
      youtubeVid: "https://www.youtube.com/watch?v=MHMQi9jygMA",
      description:
          "Classic Italian pasta dish with creamy egg and cheese sauce, topped with crispy pancetta.",
      backdrop:
          "https://example.com/spaghetti_carbonara_backdrop.jpg",
      peopleReviewed: 50,
      ingredients: [
        ["Spaghetti", "200g"],
        ["Eggs", "2"],
        ["Pancetta", "100g"],
        ["Grated Parmesan cheese", "50g"],
        ["Black pepper", "to taste"],
      ],
      allIngredients: {
        "Spaghetti": "200g",
        "Eggs": "2",
        "Pancetta": "100g",
        "Grated Parmesan cheese": "50g",
        "Black pepper": "0g",
      },
    );

  }