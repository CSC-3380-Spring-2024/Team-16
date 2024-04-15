package com.example.foodApp.Backend;

import java.util.HashMap;
import java.util.Map;

import org.bson.types.ObjectId;

import com.example.foodApp.Recipe.Recipe;

public class RecipeManager {
    private Map<ObjectId, Recipe> recipes;

    public RecipeManager() {
        recipes = new HashMap<>();
    }

    // Method to add a recipe to the manager
    public void addRecipe(Recipe recipe) {
        recipes.put(recipe.getId(), recipe);
    }

    // Method to remove a recipe from the manager
    public void removeRecipe(ObjectId recipeId) {
        recipes.remove(recipeId);
    }

    // Method to get a recipe from the manager by ID
    public Recipe getRecipe(ObjectId recipeId) {
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