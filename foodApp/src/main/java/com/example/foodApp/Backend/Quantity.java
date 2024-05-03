package com.example.foodApp.Backend;
import com.example.foodApp.Ingredient.IngredientInfo;

public class Quantity {
    public double dryToGram(double quantity, String unit, Ingredient ingredient) {
        IngredientInfo ingredientInfo = ingredient.getIngredientInfo();
        switch (unit.toLowerCase()) {
            case "kg", "kilograms":
                return quantity * 1000;
            case "g", "grams":
                return quantity;
            case "mg", "milligrams":
                return quantity / 1000;
            case "lbs", "lb":
                return quantity * 453.592; // 1 lb = 453.592 grams
            case "oz":
                return quantity * 28.3495; // 1 oz = 28.3495 grams
            case "unit(regular)","unit","","head","units":
                return quantity * ingredientInfo.getGramPerUnit(); // 1 unit * grams per units = grams
            case "unit(baby)", "cloves","clove":
                return quantity * ingredientInfo.getGramPerUnit() / 8;
            case "slice", "slices":
                return quantity * ingredientInfo.getGramPerUnit() / 32;
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }

    public double inverseDryToGram(double grams, String unit, Ingredient ingredient) {
        IngredientInfo ingredientInfo = ingredient.getIngredientInfo();
        switch (unit.toLowerCase()) {
            case "kg", "kilograms":
                return grams / 1000;
            case "g", "grams":
                return grams;
            case "mg", "milligrams":
                return grams * 1000;
            case "lbs", "lb":
                return grams / 453.592; // 1 lb = 453.592 grams
            case "oz":
                return grams / 28.3495; // 1 oz = 28.3495 grams
            case "unit(regular)","unit","","head","units":
                return grams / ingredientInfo.getGramPerUnit(); // grams / grams per unit = units
            case "unit(baby)", "cloves","clove":
                return grams / (ingredientInfo.getGramPerUnit() / 8);
            case "slice", "slices":
                return grams / (ingredientInfo.getGramPerUnit() / 32);
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }
    public double volumeToMilliliter(double quantity, String unit) {
        switch (unit.toLowerCase()) {
            case "gal", "gallon":
                return quantity * 3785.41; // 1 US gallon = 3785.41 milliliters
            case "quart","qt":
                return quantity * 946.353; // 1 quart = 946.353 milliliters
            case "pint","pt":
                return quantity * 473.176; // 1 pint = 473.176 milliliters
            case "cup","cups":
                return quantity * 236.588; // 1 cup = 236.588 milliliters
            case "oz":
                return quantity * 29.5735; // 1 fluid ounce = 29.5735 milliliters
            case "tbsp":
                return quantity * 14.7868; // 1 tablespoon = 14.7868 milliliters
            case "tsp":
                return quantity * 4.92892; // 1 teaspoon = 4.92892 milliliters
            case "l", "liter":
                return quantity * 1000; // 1 liter = 1000 milliliters
            case "ml", "milliliter":
                return quantity; // Milliliter to milliliter, no conversion needed
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }

    public double inverseVolumeToMilliliter(double milliliters, String unit) {
        switch (unit.toLowerCase()) {
            case "gal", "gallon":
                return milliliters / 3785.41; // 1 US gallon = 3785.41 milliliters
            case "quart","qt":
                return milliliters / 946.353; // 1 quart = 946.353 milliliters
            case "pint","pt":
                return milliliters / 473.176; // 1 pint = 473.176 milliliters
            case "cup","cups":
                return milliliters / 236.588; // 1 cup = 236.588 milliliters
            case "oz":
                return milliliters / 29.5735; // 1 fluid ounce = 29.5735 milliliters
            case "tbsp":
                return milliliters / 14.7868; // 1 tablespoon = 14.7868 milliliters
            case "tsp":
                return milliliters / 4.92892; // 1 teaspoon = 4.92892 milliliters
            case "l", "liter":
                return milliliters / 1000; // 1 liter = 1000 milliliters
            case "ml", "milliliter":
                return milliliters; // Milliliter to milliliter, no conversion needed
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }
}

