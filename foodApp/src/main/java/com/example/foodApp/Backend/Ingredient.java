package com.example.foodApp.Backend;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.example.foodApp.Ingredient.IngredientInfo;
import com.example.foodApp.Ingredient.IngredientInfoService;

public class Ingredient {
    private String name;
    private String quantity;
    private int expiry;
    private IngredientInfo ingredientInfo;

    // Map to store ingredient name to IngredientInfo
    // private static Map<String, IngredientInfo> ingredientInfoMap = new HashMap<>();
    public Ingredient(String name, String quantity, int expiry) {
        this.name = name;
        this.quantity = quantity;
        this.expiry = expiry;
    }

    // Method to get ingredient info for a particular ingredient name
    public IngredientInfo getIngredientInfo() {//String ingredientName) {
        //return ingredientInfoMap.get(ingredientName);
        return this.ingredientInfo;
    }
    public void setIngredientInfo(IngredientInfo newInfo) {
        this.ingredientInfo = newInfo;
    }

    // Getter for name
    public String getName() {
        return name;
    }

    // Method to parse the quantity string into a double quantity
    public double getQuantity() {
        IngredientInfoService ingredientInfoService = new IngredientInfoService();
        List<String> similarStrings = ingredientInfoService.similarIngredientInfo(getIngredientInfo());

        if (similarStrings == null || similarStrings.isEmpty()) {
            return parseQuantity(); // If no similar strings found, return the parsed quantity
        } else {
            // Instantiate the pantry
            Pantry pantry = new Pantry();

            // Initialize variables to accumulate total quantity and unit
            double totalQuantityInGramsOrMilliliters = 0.0;

            // Iterate through each similar string
            for (String similarString : similarStrings) {
                // Check if the pantry contains an ingredient with the similar string's name
                if (pantry.getAllIngredients().containsKey(similarString)) {
                    // Get the ingredient from the pantry
                    Ingredient pantryIngredient = pantry.getIngredientByName(similarString);

                    // Parse the quantity and unit for the ingredient from the pantry
                    double ingredientQuantity = parseQuantity();
                    String ingredientUnit = parseUnit();

                    // Convert the ingredient quantity to grams or milliliters based on its unit
                    double quantityInGramsOrMilliliters;
                    if (pantryIngredient.getIngredientInfo().isLiquid()) {
                        quantityInGramsOrMilliliters = new Quantity().volumeToMilliliter(ingredientQuantity, ingredientUnit);
                    } else {
                        quantityInGramsOrMilliliters = new Quantity().dryToGram(ingredientQuantity, ingredientUnit, pantryIngredient);
                    }

                    // Add the converted quantity to the total
                    totalQuantityInGramsOrMilliliters += quantityInGramsOrMilliliters;
                }
            }

            // Return the total quantity in grams or milliliters
            return totalQuantityInGramsOrMilliliters;
        }
    }

    // Method to extract the unit from the quantity string
    public String getUnit() {
        IngredientInfoService ingredientInfoService = new IngredientInfoService();
        List<String> similarStrings = ingredientInfoService.similarIngredientInfo(getIngredientInfo());
        if(similarStrings == null) return parseUnit();
        else{
            if (getIngredientInfo().isLiquid() == true) return "ml";
            else return "g";
        }
    }

    // Getter for expiry
    public int getExpiry() {
        return expiry;
    }

    // Method to parse the quantity string into a double quantity
    private double parseQuantity() {
        Pattern pattern = Pattern.compile("(\\d+(?:\\.\\d+)?)\\s*(?:/\\s*(\\d+(?:\\.\\d+)?))?"); // match one or more digits with optional decimal point, optionally followed by a slash and another number
        Matcher matcher = pattern.matcher(quantity);
        if (matcher.find()) {
            String firstNumber = matcher.group(1);
            String secondNumber = matcher.group(2);
            if (secondNumber != null) {
                double num1 = Double.parseDouble(firstNumber);
                double num2 = Double.parseDouble(secondNumber);
                if (num2 != 0) {
                    return num1 / num2;
                } else {
                    // Handle division by zero error
                    throw new ArithmeticException("Division by zero");
                }
            } else {
                return Double.parseDouble(matcher.group());
            }
        }
        return 0; // default value if no match is found
    }
    // Method to extract the unit from the quantity string
    private String parseUnit() {
        Pattern pattern = Pattern.compile("[a-zA-Z]+"); // match one or more letters
        Matcher matcher = pattern.matcher(quantity);
        if (matcher.find()) {
            return matcher.group();
        }
        return ""; // default value if no match is found
    }

    // change quantity of the pantry's ingredients
    public void setNewQuantity(double newQuantity) {
        // Extract unit from the current quantity
        String unit = parseUnit();
    
        // Reconstruct the quantity string with the new numeric value and the same unit
        quantity = String.format("%.2f%s", newQuantity, unit);
    }
}