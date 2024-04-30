
import 'package:foodappproject/backend/backend.dart';

class Quantity {
  static double dryToGram(double quantity, String unit) {
    //IngredientInfo ingredientInfo = ingredient.ingredientInfo;
    switch (unit.toLowerCase()) {
      case "kg":
      case "kilograms":
        return quantity * 1000;
      case "g":
      case "grams":
        return quantity;
      case "mg":
      case "milligrams":
        return quantity / 1000;
      case "lbs":
      case "lb":
        return quantity * 453.592; // 1 lb = 453.592 grams
      case "oz":
        return quantity * 28.3495; // 1 oz = 28.3495 grams
      case "unit(regular)":
      case "unit":
      case "":
        //return quantity * ingredientInfo.gramPerUnit; // 1 unit * grams per units = grams
      case "unit(baby)":
      case "cloves":
        //return quantity * ingredientInfo.gramPerUnit / 5;
      default:
        throw ArgumentError("Invalid unit: $unit");
    }
  }

  static double inverseDryToGram(double grams, String unit) {
    //IngredientInfo ingredientInfo = ingredient.ingredientInfo;
    switch (unit.toLowerCase()) {
      case "kg":
      case "kilograms":
        return grams / 1000;
      case "g":
      case "grams":
        return grams;
      case "mg":
      case "milligrams":
        return grams * 1000;
      case "lbs":
      case "lb":
        return grams / 453.592; // 1 lb = 453.592 grams
      case "oz":
        return grams / 28.3495; // 1 oz = 28.3495 grams
      case "unit(regular)":
      case "unit":
      case "":
        //return grams / ingredientInfo.gramPerUnit; // grams / grams per unit = units
      case "unit(baby)":
      case "cloves":
        //return grams / (ingredientInfo.gramPerUnit / 5);
      default:
        throw ArgumentError("Invalid unit: $unit");
    }
  }

  static double volumeToMilliliter(double quantity, String unit) {
    switch (unit.toLowerCase()) {
      case "gal":
        return quantity * 3785.41; // 1 US gallon = 3785.41 milliliters
      case "qt":
        return quantity * 946.353; // 1 quart = 946.353 milliliters
      case "pt":
        return quantity * 473.176; // 1 pint = 473.176 milliliters
      case "cup":
        return quantity * 236.588; // 1 cup = 236.588 milliliters
      case "fl oz":
        return quantity * 29.5735; // 1 fluid ounce = 29.5735 milliliters
      case "tbsp":
        return quantity * 14.7868; // 1 tablespoon = 14.7868 milliliters
      case "tsp":
        return quantity * 4.92892; // 1 teaspoon = 4.92892 milliliters
      case "l":
      case "liter":
        return quantity * 1000; // 1 liter = 1000 milliliters
      case "ml":
      case "milliliter":
        return quantity; // Milliliter to milliliter, no conversion needed
      default:
        throw new ArgumentError("Invalid unit: $unit");
    }
  }

  static double inverseVolumeToMilliliter(double milliliters, String unit) {
    switch (unit.toLowerCase()) {
      case "gallon":
        return milliliters / 3785.41; // 1 US gallon = 3785.41 milliliters
      case "quart":
        return milliliters / 946.353; // 1 quart = 946.353 milliliters
      case "pint":
        return milliliters / 473.176; // 1 pint = 473.176 milliliters
      case "cup":
        return milliliters / 236.588; // 1 cup = 236.588 milliliters
      case "fluid oz":
        return milliliters / 29.5735; // 1 fluid ounce = 29.5735 milliliters
      case "tbsp":
        return milliliters / 14.7868; // 1 tablespoon = 14.7868 milliliters
      case "tsp":
        return milliliters / 4.92892; // 1 teaspoon = 4.92892 milliliters
      case "l":
      case "liter":
        return milliliters / 1000; // 1 liter = 1000 milliliters
      case "ml":
      case "milliliter":
        return milliliters; // Milliliter to milliliter, no conversion needed
      default:
        throw new ArgumentError("Invalid unit: $unit");
    }
  }

  static QuantityStruct parseQuantity(String quantityString) {
    double quantity = 0;
    RegExp pattern = RegExp(r"(\d+(?:\.\d+)?)"); // match one or more digits with optional decimal point
    RegExpMatch? match = pattern.firstMatch(quantityString);
    if (match != null) {
      quantity = double.parse(match.group(0)!);
    }

    String unit = "";
    RegExp strPattern = RegExp(r"[a-zA-Z]+"); // match one or more letters
    RegExpMatch? strMatch = strPattern.firstMatch(quantityString);
    if (match != null) {
      unit = strMatch!.group(0)!;
    }
    return QuantityStruct(quantity: quantity, unit: unit);
  }
}

class QuantityStruct {
  late double quantity;
  late String unit;
  QuantityStruct({
    required this.quantity,
    required this.unit,
  });
}