package com.example.foodApp.Backend;
import com.example.foodApp.Recipe.Recipe;
import com.example.foodApp.Ingredient.IngredientInfo;
import org.bson.types.ObjectId;

import java.util.*;

public class IngredientRelated {
    public static class Ingredient {
        private String name;
        private double quantity;
        private String unit;

        // Map to store ingredient name to IngredientInfo
        private static Map<String, IngredientInfo> ingredientInfoMap = new HashMap<>();
        public Ingredient(String name, double quantity, String unit) {
            this.name = name;
            this.quantity = quantity;
            this.unit = unit;
        }

        // Method to get ingredient info for a particular ingredient name
        public static IngredientInfo getIngredientInfo(String ingredientName) {
            return ingredientInfoMap.get(ingredientName);
        }

        // Getter for name
        public String getName() {
            return name;
        }

        // Getter for quantity
        public double getQuantity() {
            return quantity;
        }

        // change quantity of the pantry's ingredients
        public void getNewQuantity(double newQuantity) {
            quantity = newQuantity;
        }
        // Getter for unit
        public String getUnit() {
            return unit;
        }
    }

    public static class RecipeManager {
        private Map<ObjectId, Recipe> recipes;

        private RecipeManager() {
            recipes = new HashMap<>();
        }

        // Method to add a recipe to the manager
        public void addRecipe(Recipe recipe) {
            recipes.put(recipe.getId(), recipe);
        }

        // Method to remove a recipe from the manager
        public void removeRecipe(int recipeId) {
            recipes.remove(recipeId);
        }

        // Method to get a recipe from the manager by ID
        public Recipe getRecipe(int recipeId) {
            return recipes.get(recipeId);
        }

        // Method to get all recipes from the manager
        public Map<ObjectId, Recipe> getAllRecipes() {
            return recipes;
        }

        // Method to clear all recipes from the manager
        public void clearRecipes() {
            recipes.clear();
        }

        public float getStarRating(ObjectId id) {
            Recipe recipe = recipes.get(id);
            return recipe.getStarRating();
        }
        public float getDifficultyRating(ObjectId id) {
            Recipe recipe = recipes.get(id);
            return recipe.getDifficultyRating();
        }
    }

    public static class Pantry {
        Map<String, Ingredient> ingredients;

        private Pantry() {
            ingredients = new HashMap<>();
        }

        // Method to get all ingredients in the pantry
        public Map<String, Ingredient> getAllIngredients() {
            return ingredients;
        }

        // Method to use an ingredient in a recipe and update its quantity in the pantry
        public void useIngredient(Ingredient ingredient) {
            Ingredient pantryIngredient = ingredients.get(ingredient.name);
            Quantity quantity = new Quantity();
            if (pantryIngredient != null) {
                double usedQuantity;
                IngredientInfo pantryIngredientInfo = ingredient.getIngredientInfo(pantryIngredient.name);
                if (pantryIngredientInfo.isLiquid()) {
                    usedQuantity = quantity.volumeToMilliliter(ingredient.quantity, ingredient.unit);
                    pantryIngredient.quantity = quantity.volumeToMilliliter(pantryIngredient.quantity, pantryIngredient.unit);
                } else {
                    usedQuantity = quantity.dryToGram(ingredient.quantity, ingredient.unit, ingredient);
                    pantryIngredient.quantity = quantity.dryToGram(pantryIngredient.quantity, pantryIngredient.unit, pantryIngredient);
                }
                double remainingQuantity = pantryIngredient.quantity - usedQuantity;
                if (remainingQuantity > 0) {
                    if (pantryIngredientInfo.isLiquid()) {
                        pantryIngredient.quantity = quantity.inverseVolumeToMilliliter(remainingQuantity, pantryIngredient.unit);
                    } else {
                        pantryIngredient.quantity = quantity.inverseDryToGram(remainingQuantity, pantryIngredient.unit, pantryIngredient);
                    }
                } else {
                    ingredients.remove(pantryIngredient.name);
                }
            }
        }
        // Method to use the ingredients from a recipe in the pantry
        public static void useRecipeIngredientsInPantry(Recipe recipe, Pantry pantry) {
            for (Ingredient ingredient : recipe.getAllIngredients().values()) {
                pantry.useIngredient(ingredient);
            }
        }
        // Method to print the contents of the pantry
        public static void printPantryContents(Pantry pantry) {
            Map<String, IngredientRelated.Ingredient> pantryIngredients = pantry.getAllIngredients();
            for (Map.Entry<String, IngredientRelated.Ingredient> entry : pantryIngredients.entrySet()) {
                String ingredientName = entry.getKey();
                IngredientRelated.Ingredient ingredient = entry.getValue();
                System.out.println("Ingredient: " + ingredientName + ", Quantity: " + ingredient.quantity + " " + ingredient.unit);
            }
        }
    }
}

