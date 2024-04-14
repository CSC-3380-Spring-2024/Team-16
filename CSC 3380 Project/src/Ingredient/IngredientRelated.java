package Ingredient;
import Functions.Quantity;
import Functions.Fuzzy;
import java.util.*;

public class IngredientRelated {
    public static class Ingredient {
        public String name;
        public int expiry; // days
        public double quantity;
        public double AppropriateQuantity;
        public String unit;
        public static double gram_per_unit;
        public Boolean is_liquid;
        public Ingredient(String name, int expiry, double quantity, String unit, double gram_per_unit, Boolean is_liquid) {
            this.name = name;
            this.expiry = expiry;
            this.quantity = quantity;
            this.unit = unit;
            this.gram_per_unit = gram_per_unit;
            this.is_liquid = is_liquid;
        }
    }

    public static class Recipe {
        private static int nextInternalId = 1; // Static variable to generate unique internal IDs
        private int internalId; // Internal ID used within the code
        private int databaseId; // Database ID
        private float starRating; // Star rating of the recipe
        private float difficultyRating; // Difficulty rating of the recipe
        private int servingSize; // Serving size of the recipe
        private Map<String, Ingredient> ingredients;

        public Recipe(int databaseId) {
            this.internalId = nextInternalId++; // Assign the next available internal ID to the recipe
            this.databaseId = databaseId;
            ingredients = new HashMap<>();
        }

        // Method to add an ingredient to the recipe
        public void addIngredient(Ingredient ingredient) {
            ingredients.put(ingredient.name, ingredient);
        }

        // Method to remove an ingredient from the recipe
        public void removeIngredient(String ingredientName) {
            ingredients.remove(ingredientName);
        }

        // Method to get an ingredient from the recipe
        public Ingredient getIngredient(String ingredientName) {
            return ingredients.get(ingredientName);
        }

        // Method to get all ingredients in the recipe
        public Map<String, Ingredient> getAllIngredients() {
            return ingredients;
        }

        // Method to clear all ingredients from the recipe
        public void clearIngredients() {
            ingredients.clear();
        }

        // Method to get the database ID of the recipe
        public int getDatabaseId() {
            return databaseId;
        }

        // Method to get the internal ID of the recipe
        public int getInternalId() {
            return internalId;
        }

        // Method to get the star rating of the recipe
        public float getStarRating() {
            return starRating;
        }

        // Method to set the star rating of the recipe
        public void setStarRating(float rating) {
            starRating = rating;
        }

        // Method to get the star rating of the recipe
        public float getDifficultyRating() {
            return difficultyRating;
        }

        // Method to set the star rating of the recipe
        public void setDifficultyRating(float rating) {
            difficultyRating = rating;
        }

        // Method to get the serving size of the recipe
        public int getServingSize() {
            return servingSize;
        }

        // Method to set the serving size of the recipe
        public void setServingSize(int servingSize) {
            this.servingSize = servingSize;
        }
    }


    public static class RecipeManager {
        private Map<Integer, Recipe> recipes;

        public RecipeManager() {
            recipes = new HashMap<>();
        }

        // Method to add a recipe to the manager
        public void addRecipe(Recipe recipe) {
            recipes.put(recipe.getDatabaseId(), recipe);
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
        public Map<Integer, Recipe> getAllRecipes() {
            return recipes;
        }

        // Method to clear all recipes from the manager
        public void clearRecipes() {
            recipes.clear();
        }

        public float getStarRating(int recipeId) {
            Recipe recipe = recipes.get(recipeId);
            return recipe.getStarRating();
        }
        public float getDifficultyRating(int recipeId) {
            Recipe recipe = recipes.get(recipeId);
            return recipe.getDifficultyRating();
        }
    }

    public static class Pantry {
        Map<String, Ingredient> ingredients;

        public Pantry() {
            ingredients = new HashMap<>();
        }

        // Method to add an ingredient to the pantry
        public void addIngredient(Ingredient ingredient) {
            ingredients.put(ingredient.name, ingredient);
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
                if (pantryIngredient.is_liquid) {
                    usedQuantity = quantity.volumeToMilliliter(ingredient.quantity, ingredient.unit);
                    pantryIngredient.quantity = quantity.volumeToMilliliter(pantryIngredient.quantity, pantryIngredient.unit);
                } else {
                    usedQuantity = quantity.dryToGram(ingredient.quantity, ingredient.unit);
                    pantryIngredient.quantity = quantity.dryToGram(pantryIngredient.quantity, pantryIngredient.unit);
                }

                double remainingQuantity = pantryIngredient.quantity - usedQuantity;
                if (remainingQuantity > 0) {
                    if (pantryIngredient.is_liquid) {
                        pantryIngredient.quantity = quantity.inverseVolumeToMilliliter(remainingQuantity, pantryIngredient.unit);
                    } else {
                        pantryIngredient.quantity = quantity.inverseDryToGram(remainingQuantity, pantryIngredient.unit);
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
