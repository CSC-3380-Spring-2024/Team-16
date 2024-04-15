package com.example.foodApp.Backend;
import com.example.foodApp.Ingredient.IngredientInfo;

public class Quantity {
    public double dryToGram(double quantity, String unit, Ingredient ingredient) {
        IngredientInfo ingredientInfo = ingredient.getIngredientInfo();
        switch (unit.toLowerCase()) {
            case "kg":
                return quantity * 1000;
            case "g":
                return quantity;
            case "mg":
                return quantity / 1000;
            case "lbs":
                return quantity * 453.592; // 1 lb = 453.592 grams
            case "oz":
                return quantity * 28.3495; // 1 oz = 28.3495 grams
            case "unit(regular)":
                return quantity * ingredientInfo.getGramPerUnit(); // 1 unit * grams per units = grams
            case "unit(baby)":
                return quantity * ingredientInfo.getGramPerUnit() / 5;
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }

    public double inverseDryToGram(double grams, String unit, Ingredient ingredient) {
        IngredientInfo ingredientInfo = ingredient.getIngredientInfo();
        switch (unit.toLowerCase()) {
            case "kg":
                return grams / 1000;
            case "g":
                return grams;
            case "mg":
                return grams * 1000;
            case "lbs":
                return grams / 453.592; // 1 lb = 453.592 grams
            case "oz":
                return grams / 28.3495; // 1 oz = 28.3495 grams
            case "unit(regular)":
                return grams / ingredientInfo.getGramPerUnit(); // grams / grams per unit = units
            case "unit(baby)":
                return grams / (ingredientInfo.getGramPerUnit() / 5);
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }
    public double volumeToMilliliter(double quantity, String unit) {
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
                return quantity * 1000; // 1 liter = 1000 milliliters
            case "ml":
                return quantity; // Milliliter to milliliter, no conversion needed
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }

    public double inverseVolumeToMilliliter(double milliliters, String unit) {
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
                return milliliters / 1000; // 1 liter = 1000 milliliters
            case "ml":
                return milliliters; // Milliliter to milliliter, no conversion needed
            default:
                throw new IllegalArgumentException("Invalid unit: " + unit);
        }
    }
}

