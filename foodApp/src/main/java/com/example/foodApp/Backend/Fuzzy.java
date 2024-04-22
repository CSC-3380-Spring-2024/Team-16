package com.example.foodApp.Backend;
import com.example.foodApp.Recipe.Recipe;
import java.util.*;

public class Fuzzy {
    public static void adjustIngredientQuantities(Recipe recipe, int servingSize) {
        // Get the ratio of new serving size to the recipe's original serving size
        double ratio = (double) servingSize / recipe.getServingSize();

        // Get all ingredients in the recipe
        Map<String, Ingredient> ingredients = recipe.getAllIngredients();

        // Iterate through each ingredient and adjust its quantity
        for (Ingredient ingredient : ingredients.values()) {
            // Calculate the new quantity based on the ratio
            double newQuantity = ingredient.getQuantity() * ratio;

            // Update the ingredient's quantity
            ingredient.setNewQuantity(newQuantity);
        }
    }

    public static double calculateMissingIngredientQuantity(Recipe recipe, Pantry pantry) {
        // Get all ingredients in the recipe
        Map<String, Ingredient> ingredients = recipe.getAllIngredients();

        // Initialize total missing quantity
        double totalMissingQuantity = 0.0;

        double missing = 1.0;

        // Iterate through each ingredient in the recipe
        for (Ingredient ingredient : ingredients.values()) {
            // Check if the ingredient exists in the pantry
            if (!pantry.getAllIngredients().containsKey(ingredient.getName())) {
                // Ingredient not found in the pantry, calculate missing quantity
                totalMissingQuantity += missing++; // add one score
            } else {
                // Ingredient found in the pantry, check if quantity is sufficient
                Ingredient pantryIngredient = pantry.getAllIngredients().get(ingredient.getName());
                if (pantryIngredient.getQuantity() < ingredient.getQuantity()) {
                    // Calculate missing quantity and add to total
                    double missingQuantity = 1 - (pantryIngredient.getQuantity() / ingredient.getQuantity());
                    double expMissing = missingQuantity * 10 / (pantryIngredient.getExpiry()+1);
                    totalMissingQuantity += expMissing;
                }
            }
        }

        // Return the total missing quantity
        return totalMissingQuantity;
    }

    public static double calculateUnusedIngredientScore(Pantry pantry, Recipe recipe) {
        // Get all ingredients in the pantry
        Map<String, Ingredient> pantryIngredients = pantry.getAllIngredients();

        // Get all ingredients in the recipe
        Map<String, Ingredient> recipeIngredients = recipe.getAllIngredients();

        // Initialize total unused ingredient score
        double totalUnusedIngredientScore = 1.0;

        // Iterate through each ingredient in the pantry
        for (Ingredient pantryIngredient : pantryIngredients.values()) {
            // Check if the ingredient is not in the recipe
            if (!recipeIngredients.containsKey(pantryIngredient.getName())) {
                // Calculate score based on expiration date
                double expirationScore = 1.0 / (pantryIngredient.getExpiry() * pantryIngredient.getExpiry());
                totalUnusedIngredientScore += expirationScore;
            }
        }

        return totalUnusedIngredientScore;
    }

    public static double generateRecipeScore(Recipe recipe, double starRating, double difficultyRating, Pantry pantry) {
        // Initialize score with a starting value of 100
        double score = 10.0;

        // Multiply score by the square of the star rating
        score *= starRating * starRating;

        // Divide score by the square root of the difficulty rating
        score /= Math.sqrt(difficultyRating);

        // Calculate the total missing quantity using the previously defined function
        double totalMissingQuantity = calculateMissingIngredientQuantity(recipe, pantry);

        // Calculate the unused ingredient score
        double unusedIngredientScore = calculateUnusedIngredientScore(pantry, recipe);

        // Divide score by the total missing quantity
        score /= (totalMissingQuantity + 1);

        // Add the unused ingredient score to the final score
        score /= unusedIngredientScore;

        // Return the final score
        return score;
    }


    //use when given 500 matching recipes:
    public static List<Map<Double, Recipe>> findTopScoringRecipes(RecipeManager recipeManager, Pantry pantry, int servingSize) {
        List<Map<Double, Recipe>> topScoringRecipes = new ArrayList<>();

        // Process each recipe in the RecipeManager
        for (Recipe recipe : recipeManager.getAllRecipes().values()) {
            // Adjust ingredient quantities
            adjustIngredientQuantities(recipe, servingSize);

            // Generate score for the recipe
            double starRating = recipeManager.getStarRating(recipe.getId());
            double difficultyRating = recipeManager.getDifficultyRating(recipe.getId());
            double score = generateRecipeScore(recipe,  starRating, difficultyRating, pantry);

            // Create a map to store score and recipe
            Map<Double, Recipe> scoreRecipeMap = new HashMap<>();
            scoreRecipeMap.put(score, recipe);

            // Add the map to the list
            topScoringRecipes.add(scoreRecipeMap);
        }

        // Sort the list based on scores in descending order
        Collections.sort(topScoringRecipes, new Comparator<Map<Double, Recipe>>() {
            @Override
            public int compare(Map<Double, Recipe> map1, Map<Double, Recipe> map2) {
                return map2.keySet().iterator().next().compareTo(map1.keySet().iterator().next());
            }
        });

        // Keep only the top 10 highest scoring recipes
        if (topScoringRecipes.size() > 10) {
            topScoringRecipes.subList(10, topScoringRecipes.size()).clear();
        }

        return topScoringRecipes;
    }
    private static double calculateRecipeGroceryScore(Recipe recipe, Pantry pantry) {
        // Initialize total score for the recipe
        double score = 0.0;

        // Iterate through each ingredient in the recipe
        for (Ingredient ingredient : recipe.getAllIngredients().values()) {
            // Check if the ingredient exists in the pantry
            if (pantry.getAllIngredients().containsKey(ingredient.getName())) {
                Ingredient pantryIngredient = pantry.getAllIngredients().get(ingredient.getName());
                // Calculate missing ratio from the quantity
                double missingRatio = 1;
                if(pantryIngredient.getQuantity() < ingredient.getQuantity()){
                    missingRatio = pantryIngredient.getQuantity() / ingredient.getQuantity();
                }
                // Adjust score based on missing ratio and expiration date
                double ingredientScore = Math.pow(missingRatio, 2) + 10 / (pantryIngredient.getExpiry() + 1);
                // Multiply recipe score by ingredient score
                score += ingredientScore;
            }
        }
        return score;
    }
    public static List<Map<Double, Recipe>> findRecipesGrocery(RecipeManager recipeManager, Pantry pantry) {
        List<Map<Double, Recipe>> topRecipesGrocery = new ArrayList<>();

        // Process each recipe in the RecipeManager
        for (Recipe recipe : recipeManager.getAllRecipes().values()) {
            // Generate score for the recipe
            double starRating = recipeManager.getStarRating(recipe.getId());
            double difficultyRating = recipeManager.getDifficultyRating(recipe.getId());
            // Initialize score with a starting value of 100
            double score = 1.0;
            // Multiply score by the square of the star rating
            score *= starRating * starRating;
            // Divide score by the square root of the difficulty rating
            score /= Math.sqrt(difficultyRating);
            score *= calculateRecipeGroceryScore(recipe, pantry);
            // Create a map to store score and recipe
            Map<Double, Recipe> scoreRecipeMap = new HashMap<>();
            scoreRecipeMap.put(score, recipe);
            // Add the map to the list
            topRecipesGrocery.add(scoreRecipeMap);
        }
        // Sort the list based on scores in descending order
        Collections.sort(topRecipesGrocery, new Comparator<Map<Double, Recipe>>() {
            @Override
            public int compare(Map<Double, Recipe> map1, Map<Double, Recipe> map2) {
                return map2.keySet().iterator().next().compareTo(map1.keySet().iterator().next());
            }
        });
        // Keep only the top 10 highest scoring recipes
        if (topRecipesGrocery.size() > 10) {
            topRecipesGrocery.subList(10, topRecipesGrocery.size()).clear();
        }

        return topRecipesGrocery;
    }
}