package Functions;
import Ingredient.IngredientRelated;
import Ingredient.IngredientRelated.*;
import java.util.*;

public class Fuzzy {
    public static void adjustIngredientQuantities(IngredientRelated.Recipe recipe, int servingSize) {
        // Get the ratio of new serving size to the recipe's original serving size
        double ratio = (double) servingSize / recipe.getServingSize();

        // Get all ingredients in the recipe
        Map<String, IngredientRelated.Ingredient> ingredients = recipe.getAllIngredients();

        // Iterate through each ingredient and adjust its quantity
        for (IngredientRelated.Ingredient ingredient : ingredients.values()) {
            // Calculate the new quantity based on the ratio
            double newQuantity = ingredient.quantity * ratio;

            // Update the ingredient's quantity
            ingredient.quantity = newQuantity;
        }
    }

    public static double calculateMissingIngredientQuantity(IngredientRelated.Recipe recipe, IngredientRelated.Pantry pantry) {
        // Get all ingredients in the recipe
        Map<String, IngredientRelated.Ingredient> ingredients = recipe.getAllIngredients();

        // Initialize total missing quantity
        double totalMissingQuantity = 0.0;

        // Iterate through each ingredient in the recipe
        for (IngredientRelated.Ingredient ingredient : ingredients.values()) {
            // Check if the ingredient exists in the pantry
            if (!pantry.getAllIngredients().containsKey(ingredient.name)) {
                // Ingredient not found in the pantry, calculate missing quantity
                totalMissingQuantity += 1.0; // add one score
            } else {
                // Ingredient found in the pantry, check if quantity is sufficient
                IngredientRelated.Ingredient pantryIngredient = pantry.getAllIngredients().get(ingredient.name);
                if (pantryIngredient.quantity < ingredient.quantity) {
                    // Calculate missing quantity and add to total
                    double missingQuantity = 1 - (pantryIngredient.quantity / ingredient.quantity);
                    double expMissing = missingQuantity * 10 / (pantryIngredient.expiry+1);
                    totalMissingQuantity += expMissing;
                }
            }
        }

        // Return the total missing quantity
        return totalMissingQuantity;
    }

    public static double calculateUnusedIngredientScore(IngredientRelated.Pantry pantry, IngredientRelated.Recipe recipe) {
        // Get all ingredients in the pantry
        Map<String, IngredientRelated.Ingredient> pantryIngredients = pantry.getAllIngredients();

        // Get all ingredients in the recipe
        Map<String, IngredientRelated.Ingredient> recipeIngredients = recipe.getAllIngredients();

        // Initialize total unused ingredient score
        double totalUnusedIngredientScore = 1.0;

        // Iterate through each ingredient in the pantry
        for (IngredientRelated.Ingredient pantryIngredient : pantryIngredients.values()) {
            // Check if the ingredient is not in the recipe
            if (!recipeIngredients.containsKey(pantryIngredient.name)) {
                // Calculate score based on expiration date
                double expirationScore = 1.0 / (pantryIngredient.expiry * pantryIngredient.expiry);
                totalUnusedIngredientScore += expirationScore;
            }
        }

        return totalUnusedIngredientScore;
    }

    public static double generateRecipeScore(IngredientRelated.Recipe recipe, float starRating, float difficultyRating, IngredientRelated.Pantry pantry) {
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
    public static List<Map<Double, IngredientRelated.Recipe>> findTopScoringRecipes(IngredientRelated.RecipeManager recipeManager, IngredientRelated.Pantry pantry, int servingSize) {
        List<Map<Double, IngredientRelated.Recipe>> topScoringRecipes = new ArrayList<>();

        // Process each recipe in the RecipeManager
        for (IngredientRelated.Recipe recipe : recipeManager.getAllRecipes().values()) {
            // Adjust ingredient quantities
            adjustIngredientQuantities(recipe, servingSize);

            // Generate score for the recipe
            float starRating = recipeManager.getStarRating(recipe.getDatabaseId());
            float difficultyRating = recipeManager.getDifficultyRating(recipe.getDatabaseId());
            double score = generateRecipeScore(recipe, starRating, difficultyRating, pantry);

            // Create a map to store score and recipe
            Map<Double, IngredientRelated.Recipe> scoreRecipeMap = new HashMap<>();
            scoreRecipeMap.put(score, recipe);

            // Add the map to the list
            topScoringRecipes.add(scoreRecipeMap);
        }

        // Sort the list based on scores in descending order
        Collections.sort(topScoringRecipes, new Comparator<Map<Double, IngredientRelated.Recipe>>() {
            @Override
            public int compare(Map<Double, IngredientRelated.Recipe> map1, Map<Double, IngredientRelated.Recipe> map2) {
                return map2.keySet().iterator().next().compareTo(map1.keySet().iterator().next());
            }
        });

        // Keep only the top 10 highest scoring recipes
        if (topScoringRecipes.size() > 10) {
            topScoringRecipes.subList(10, topScoringRecipes.size()).clear();
        }

        return topScoringRecipes;
    }
}
