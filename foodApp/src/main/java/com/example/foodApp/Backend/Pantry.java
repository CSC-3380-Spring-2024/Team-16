package com.example.foodApp.Backend;

import java.util.HashMap;
import java.util.Map;

import com.example.foodApp.Ingredient.IngredientInfo;
import com.example.foodApp.Recipe.Recipe;

public class Pantry {
    Map<String, Ingredient> ingredients;
    
    public void addIngredient(Ingredient ingredient) {
        ingredients.put(ingredient.getName(), ingredient);
    }

    public Pantry() {
        ingredients = new HashMap<>();
    }

    // Method to get all ingredients in the pantry
    public Map<String, Ingredient> getAllIngredients() {
        return ingredients;
    }

    // Method to use an ingredient in a recipe and update its quantity in the pantry
    public void useIngredient(Ingredient ingredient) {
        Ingredient pantryIngredient = ingredients.get(ingredient.getName());
        Quantity quantity = new Quantity();
        if (pantryIngredient != null) {
            double usedQuantity;
            IngredientInfo pantryIngredientInfo = ingredient.getIngredientInfo();
            if (pantryIngredientInfo.isLiquid()) {
                usedQuantity = quantity.volumeToMilliliter(ingredient.getQuantity(), ingredient.getUnit());
                pantryIngredient.setNewQuantity(quantity.volumeToMilliliter(pantryIngredient.getQuantity(), pantryIngredient.getUnit()));
            } else {
                usedQuantity = quantity.dryToGram(ingredient.getQuantity(), ingredient.getUnit(), ingredient);
                pantryIngredient.setNewQuantity(quantity.dryToGram(pantryIngredient.getQuantity(), pantryIngredient.getUnit(), pantryIngredient));
            }
            double remainingQuantity = pantryIngredient.getQuantity() - usedQuantity;
            if (remainingQuantity > 0) {
                if (pantryIngredientInfo.isLiquid()) {
                    pantryIngredient.setNewQuantity(quantity.inverseVolumeToMilliliter(remainingQuantity, pantryIngredient.getUnit()));
                } else {
                    pantryIngredient.setNewQuantity(quantity.inverseDryToGram(remainingQuantity, pantryIngredient.getUnit(), pantryIngredient));
                }
            } else {
                ingredients.remove(pantryIngredient.getName());
            }
        }
    }
    public Ingredient getIngredientByName(String name) {
        return ingredients.get(name);
    }
    // Method to use the ingredients from a recipe in the pantry
    public static void useRecipeIngredientsInPantry(Recipe recipe, Pantry pantry) {
        for (Ingredient ingredient : recipe.getAllIngredients().values()) {
            pantry.useIngredient(ingredient);
        }
    }
    // Method to print the contents of the pantry
    public static void printPantryContents(Pantry pantry) {
        Map<String, Ingredient> pantryIngredients = pantry.getAllIngredients();
        for (Map.Entry<String, Ingredient> entry : pantryIngredients.entrySet()) {
            String ingredientName = entry.getKey();
            Ingredient ingredient = entry.getValue();
            System.out.println("Ingredient: " + ingredientName + ", Quantity: " + ingredient.getQuantity() + " " + ingredient.getUnit());
        }
    }
}