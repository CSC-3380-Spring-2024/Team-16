
import 'package:foodappproject/app_data.dart';

class Quantity {
  static double dryToGram(QuantityStruct quantityStruct, IngredientData ingredientData) {
    
    String unit = quantityStruct.unit;
    double amount = quantityStruct.amount;

    switch (unit.toLowerCase()) {
      case "kg":
      case "kilograms":
        return amount * 1000;
      case "g":
      case "grams":
        return amount;
      case "mg":
      case "milligrams":
        return amount / 1000;
      case "lbs":
      case "lb":
        return amount * 453.592; // 1 lb = 453.592 grams
      case "oz":
        return amount * 28.3495; // 1 oz = 28.3495 grams
      case "unit(regular)":
      case "unit":
      case "":
        return amount * ingredientData.ingredientInfo!.gramPerUnit; // 1 unit * grams per units = grams
      case "unit(baby)":
      case "cloves":
        return amount * ingredientData.ingredientInfo!.gramPerUnit / 5;
      default:
        throw ArgumentError("Invalid unit: $unit");
    }
  }

  static double inverseDryToGram(double grams, String unit, IngredientInfo ingredientInfo) {
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
        return grams / ingredientInfo.gramPerUnit; // grams / grams per unit = units
      case "unit(baby)":
      case "cloves":
        return grams / (ingredientInfo.gramPerUnit / 5);
      default:
        throw ArgumentError("Invalid unit: $unit");
    }
  }

  static double volumeToMilliliter(QuantityStruct quantityStruct, IngredientData ingredientData) {

    String unit = quantityStruct.unit;
    double amount = quantityStruct.amount;

    switch (unit.toLowerCase()) {
      case "gal":
        return amount * 3785.41; // 1 US gallon = 3785.41 milliliters
      case "qt":
        return amount * 946.353; // 1 quart = 946.353 milliliters
      case "pt":
        return amount * 473.176; // 1 pint = 473.176 milliliters
      case "cup":
        return amount * 236.588; // 1 cup = 236.588 milliliters
      case "fl oz":
        return amount * 29.5735; // 1 fluid ounce = 29.5735 milliliters
      case "tbsp":
        return amount * 14.7868; // 1 tablespoon = 14.7868 milliliters
      case "tsp":
        return amount * 4.92892; // 1 teaspoon = 4.92892 milliliters
      case "l":
      case "liter":
        return amount * 1000; // 1 liter = 1000 milliliters
      case "ml":
      case "milliliter":
        return amount; // Milliliter to milliliter, no conversion needed
      default:
        throw new ArgumentError("Invalid unit: $unit");
    }
  }

  static double inverseVolumeToMilliliter(double milliliters, String unit, IngredientInfo ingredientInfo) {
    switch (unit.toLowerCase()) {
      case "gal":
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

  static QuantityStruct parseQuantity(String quantity) {
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
}

class QuantityStruct {
  late double amount;
  late String unit;
  QuantityStruct({
    required this.amount,
    required this.unit,
  });

}