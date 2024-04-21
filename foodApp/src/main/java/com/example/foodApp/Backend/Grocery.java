package com.example.foodApp.Backend;
import com.example.foodApp.Backend.Pantry;
import com.example.foodApp.Backend.Fuzzy;
import com.example.foodApp.Backend.Quantity;
import com.example.foodApp.Recipe.Recipe;

import java.util.*;

public class Grocery {
    // Function to get ingredients from the pantry that are below a specified threshold in grams
    public List<Ingredient> getEmptyIngredientsInPantry(List<Ingredient> grocery, Pantry pantry){
        Map<String, Ingredient> pantryIngredients = pantry.getAllIngredients();

        for (Map.Entry<String, Ingredient> entry : pantryIngredients.entrySet()) {
            Ingredient ingredient = entry.getValue();
            Quantity quantity = new Quantity();
            if (ingredient.getQuantity() < ingredient.getIngredientInfo().getAppropriateQuantity()) {
                // Convert the quantity to grams if the ingredient is not liquid
                if (!ingredient.getIngredientInfo().isLiquid()) {
                    double quantityInGrams = quantity.dryToGram(ingredient.getQuantity(), ingredient.getUnit(), ingredient);
                    if (quantityInGrams < ingredient.getIngredientInfo().getAppropriateQuantity()) {
                        grocery.add(ingredient);
                    }
                } else {
                    // For liquids, change the quantity to ml
                    double quantityInLiters = quantity.volumeToMilliliter(ingredient.getQuantity(), ingredient.getUnit());
                    if (quantityInLiters < ingredient.getIngredientInfo().getAppropriateQuantity()) {
                        grocery.add(ingredient);
                    }
                }
            }
        }
        return grocery;
    }
    //return the earliest to expire in pantry
    public Ingredient getEarliestExpireIngredient(Pantry pantry) {
        Map<String, Ingredient> pantryIngredients = pantry.getAllIngredients();
        // Check if the pantry is empty
        if (pantryIngredients.isEmpty()) {
            return null; // Return null if pantry is empty""
        }

        // Initialize variables to track the two ingredients with earliest expiry
        Ingredient earliestIngredient = null;

        // Iterate through the ingredients in the pantry
        for (Ingredient ingredient : pantryIngredients.values()) {
            if (earliestIngredient == null || ingredient.getExpiry() < earliestIngredient.getExpiry()) {
                // Update the earliestIngredient if it's null or if the current ingredient has an earlier expiry
                earliestIngredient = ingredient;
            }
        }
        return earliestIngredient;
    }
    public List<Ingredient> getGroceryFromRecipe(List<Ingredient> grocery, RecipeManager recipeManager, Pantry pantry) {
        List<Map<Double, Recipe>> topRecipesGrocery = Fuzzy.findRecipesGrocery(recipeManager, pantry);
        Set<String> addedIngredients = new HashSet<>(); // Set to keep track of added ingredients

        // Iterate over each map containing score and recipe
        for (Map<Double, Recipe> scoreRecipeMap : topRecipesGrocery) {
            // Iterate over each entry in the map
            for (Map.Entry<Double, Recipe> entry : scoreRecipeMap.entrySet()) {
                Recipe recipe = entry.getValue();
                // Extract ingredients from the recipe and add to the grocery list if not already added
                for (Ingredient ingredient : recipe.getAllIngredients().values()) {
                    if (!addedIngredients.contains(ingredient.getName())) {
                        grocery.add(ingredient);
                        addedIngredients.add(ingredient.getName());
                    }
                }
            }
        }
        return grocery;
    }
    public List<Ingredient> getGrocery(RecipeManager recipeManager, Pantry pantry) {
        List<Ingredient> grocery = new ArrayList<>();

        // Step 1: Get ingredients that are below a specified threshold in grams
        grocery = getEmptyIngredientsInPantry(grocery, pantry);

        // Step 2: Get the earliest expiring ingredient in the pantry
        Ingredient earliestIngredient = getEarliestExpireIngredient(pantry);
        // Get 1000 ingredients including the name of this ingredient

        // Step 3: Get ingredients from recipes based on fuzzy logic
        grocery = getGroceryFromRecipe(grocery, recipeManager, pantry);

        return grocery;
    }
}