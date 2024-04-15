package com.example.foodApp.Backend;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.example.foodApp.Ingredient.IngredientInfo;

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
        return parseQuantity();
    }

    // Method to extract the unit from the quantity string
    public String getUnit() {
        return parseUnit();
    }

    // Getter for expiry
    public int getExpiry() {
        return expiry;
    }

    // Method to parse the quantity string into a double quantity
    private double parseQuantity() {
        Pattern pattern = Pattern.compile("(\\d+(?:\\.\\d+)?)"); // match one or more digits with optional decimal point
        Matcher matcher = pattern.matcher(quantity);
        if (matcher.find()) {
            return Double.parseDouble(matcher.group());
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