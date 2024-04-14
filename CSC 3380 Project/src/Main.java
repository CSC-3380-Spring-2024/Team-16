import java.util.*;
import Functions.Quantity;
import Functions.Fuzzy;
import Ingredient.IngredientRelated;
import Ingredient.IngredientRelated.*;
import static Ingredient.IngredientRelated.*;

public class Main {
    public static void main(String[] args) {
        // Assuming recipeManager is initialized elsewhere
        // Create a new RecipeManager
        IngredientRelated.RecipeManager recipeManager = new IngredientRelated.RecipeManager();

        // Generate a pantry
        IngredientRelated.Pantry pantry = new IngredientRelated.Pantry();

        // Add some ingredients to the pantry
        pantry.addIngredient(new IngredientRelated.Ingredient("Flour", 1, 650, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Sugar", 2, 234, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Milk", 3, 1242, "ml", 1, true));
        pantry.addIngredient(new IngredientRelated.Ingredient("Eggs", 4, 2, "unit(regular)", 50, false)); // Assuming 50 grams per egg
        pantry.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 5, 150, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Butter", 6, 300, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 7, 50, "ml", 1, true));
        pantry.addIngredient(new IngredientRelated.Ingredient("Salt", 8, 20, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Baking Powder", 9, 30, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Yeast", 10, 10, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Cocoa Powder", 11, 100, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Honey", 12, 200, "ml", 1, true));
        pantry.addIngredient(new IngredientRelated.Ingredient("Ground Cinnamon", 13, 20, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Nuts", 14, 120, "g", 1, false));
        pantry.addIngredient(new IngredientRelated.Ingredient("Lemon Juice", 15, 80, "ml", 1, true));
        // Create recipes
        createRecipes(recipeManager);

        // remove recipes:
        recipeManager.removeRecipe(2);
        recipeManager.removeRecipe(5);

        // Set serving size
        int servingSize = 12; // User input

        // Find top scoring recipes, clear manager after finished
        List<Map<Double, IngredientRelated.Recipe>> topScoringRecipes = Fuzzy.findTopScoringRecipes(recipeManager, pantry, servingSize);
        recipeManager.clearRecipes();

        // Print or use the top scoring recipes as needed
        for (Map<Double, IngredientRelated.Recipe> map : topScoringRecipes) {
            for (Map.Entry<Double, IngredientRelated.Recipe> entry : map.entrySet()) {
                System.out.println("Score: " + entry.getKey() + ", Recipe: " + entry.getValue().getDatabaseId());
            }
        }

        // Use the ingredients from the highest scoring recipe in the pantry
        IngredientRelated.Recipe highestScoringRecipe = topScoringRecipes.get(0).values().iterator().next();
        pantry.useRecipeIngredientsInPantry(highestScoringRecipe, pantry);

        // Output the updated pantry contents
        System.out.println("Updated Pantry Contents:");
        pantry.printPantryContents(pantry);
    }

    // Method to create recipes and add them to the RecipeManager
    private static void createRecipes(IngredientRelated.RecipeManager recipeManager) {
        // Recipe 1
        IngredientRelated.Recipe newRecipe1 = new IngredientRelated.Recipe(1);
        newRecipe1.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 500, "g", 1, false));
        newRecipe1.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 250, "g", 1, false));
        newRecipe1.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 500, "ml", 1, true));
        newRecipe1.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 6, "unit(regular)", 50, false));
        newRecipe1.setDifficultyRating(3.5f);
        newRecipe1.setStarRating(4);
        newRecipe1.setServingSize(8);
        recipeManager.addRecipe(newRecipe1);

        // Recipe 2
        IngredientRelated.Recipe newRecipe2 = new IngredientRelated.Recipe(2);
        newRecipe2.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 400, "g", 1, false));
        newRecipe2.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 300, "ml", 1, true));
        newRecipe2.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 4, "unit(regular)", 50, false));
        newRecipe2.addIngredient(new IngredientRelated.Ingredient("Salt", 0, 5, "g", 1, false));
        newRecipe2.setDifficultyRating(2.0f);
        newRecipe2.setStarRating(5);
        newRecipe2.setServingSize(2);
        recipeManager.addRecipe(newRecipe2);

        // Recipe 3
        IngredientRelated.Recipe newRecipe3 = new IngredientRelated.Recipe(3);
        newRecipe3.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 300, "g", 1, false));
        newRecipe3.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 200, "g", 1, false));
        newRecipe3.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 400, "ml", 1, true));
        newRecipe3.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 5, "unit(regular)", 50, false));
        newRecipe3.setDifficultyRating(4.2f);
        newRecipe3.setStarRating(3);
        newRecipe3.setServingSize(12);
        recipeManager.addRecipe(newRecipe3);

        // Recipe 4 (Complex)
        IngredientRelated.Recipe newRecipe4 = new IngredientRelated.Recipe(4);
        newRecipe4.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 700, "g", 1, false));
        newRecipe4.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 350, "g", 1, false));
        newRecipe4.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 800, "ml", 1, true));
        newRecipe4.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 8, "unit(regular)", 50, false));
        newRecipe4.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 200, "g", 1, false));
        newRecipe4.setDifficultyRating(1.8f);
        newRecipe4.setStarRating(4.5f);
        newRecipe4.setServingSize(10);
        recipeManager.addRecipe(newRecipe4);

        // Recipe 5 (Complex)
        IngredientRelated.Recipe newRecipe5 = new IngredientRelated.Recipe(5);
        newRecipe5.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 600, "g", 1, false));
        newRecipe5.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 300, "g", 1, false));
        newRecipe5.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1000, "ml", 1, true));
        newRecipe5.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 10, "unit(regular)", 50, false));
        newRecipe5.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 20, "ml", 1, true));
        newRecipe5.setDifficultyRating(3.0f);
        newRecipe5.setStarRating(5);
        newRecipe5.setServingSize(6);
        recipeManager.addRecipe(newRecipe5);

        // Recipe 6 (Complex)
        IngredientRelated.Recipe newRecipe6 = new IngredientRelated.Recipe(6);
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 500, "g", 1, false));
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 400, "g", 1, false));
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1200, "ml", 1, true));
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 12, "unit(regular)", 50, false));
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 300, "g", 1, false));
        newRecipe6.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 200, "g", 1, false));
        newRecipe6.setDifficultyRating(4.7f);
        newRecipe6.setStarRating(4.2f);
        newRecipe6.setServingSize(8);
        recipeManager.addRecipe(newRecipe6);

        // Recipe 7 (Simple)
        IngredientRelated.Recipe newRecipe7 = new IngredientRelated.Recipe(7);
        newRecipe7.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 300, "g", 1, false));
        newRecipe7.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 150, "g", 1, false));
        newRecipe7.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 400, "ml", 1, true));
        newRecipe7.setDifficultyRating(2.5f);
        newRecipe7.setStarRating(3.5f);
        newRecipe7.setServingSize(6);
        recipeManager.addRecipe(newRecipe7);

        // Recipe 8 (Complex)
        IngredientRelated.Recipe newRecipe8 = new IngredientRelated.Recipe(8);
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 1000, "g", 1, false));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 500, "g", 1, false));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 800, "ml", 1, true));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 10, "unit(regular)", 50, false));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 400, "g", 1, false));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 300, "g", 1, false));
        newRecipe8.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 30, "ml", 1, true));
        newRecipe8.setDifficultyRating(4.0f);
        newRecipe8.setStarRating(4.7f);
        newRecipe8.setServingSize(12);
        recipeManager.addRecipe(newRecipe8);

        // Recipe 9 (Simple)
        IngredientRelated.Recipe newRecipe9 = new IngredientRelated.Recipe(9);
        newRecipe9.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 200, "g", 1, false));
        newRecipe9.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 300, "ml", 1, true));
        newRecipe9.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 5, "unit(regular)", 50, false));
        newRecipe9.setDifficultyRating(1.3f);
        newRecipe9.setStarRating(4.2f);
        newRecipe9.setServingSize(4);
        recipeManager.addRecipe(newRecipe9);

        // Recipe 10 (Simple)
        IngredientRelated.Recipe newRecipe10 = new IngredientRelated.Recipe(10);
        newRecipe10.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 400, "g", 1, false));
        newRecipe10.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 200, "g", 1, false));
        newRecipe10.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 150, "g", 1, false));
        newRecipe10.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 20, "ml", 1, true));
        newRecipe10.setDifficultyRating(5.0f);
        newRecipe10.setStarRating(4.5f);
        newRecipe10.setServingSize(8);
        recipeManager.addRecipe(newRecipe10);

        // Recipe 11 (Complex)
        IngredientRelated.Recipe newRecipe11 = new IngredientRelated.Recipe(11);
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 800, "g", 1, false));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 500, "g", 1, false));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1000, "ml", 1, true));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 8, "unit(regular)", 50, false));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 300, "g", 1, false));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 200, "g", 1, false));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 30, "ml", 1, true));
        newRecipe11.addIngredient(new IngredientRelated.Ingredient("Baking Powder", 0, 10, "g", 1, false));
        newRecipe11.setDifficultyRating(3.8f);
        newRecipe11.setStarRating(4.8f);
        newRecipe11.setServingSize(10);
        recipeManager.addRecipe(newRecipe11);

        // Recipe 12 (Simple)
        IngredientRelated.Recipe newRecipe12 = new IngredientRelated.Recipe(12);
        newRecipe12.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 300, "g", 1, false));
        newRecipe12.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 150, "g", 1, false));
        newRecipe12.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 200, "ml", 1, true));
        newRecipe12.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 4, "unit(regular)", 50, false));
        newRecipe12.addIngredient(new IngredientRelated.Ingredient("Baking Powder", 0, 5, "g", 1, false));
        newRecipe12.setDifficultyRating(2.1f);
        newRecipe12.setStarRating(4.0f);
        newRecipe12.setServingSize(6);
        recipeManager.addRecipe(newRecipe12);

        // Recipe 13 (Simple)
        IngredientRelated.Recipe newRecipe13 = new IngredientRelated.Recipe(13);
        newRecipe13.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 400, "g", 1, false));
        newRecipe13.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 200, "g", 1, false));
        newRecipe13.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 150, "g", 1, false));
        newRecipe13.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 20, "ml", 1, true));
        newRecipe13.setDifficultyRating(4.5f);
        newRecipe13.setStarRating(4.7f);
        newRecipe13.setServingSize(8);
        recipeManager.addRecipe(newRecipe13);

        // Recipe 14 (Simple)
        IngredientRelated.Recipe newRecipe14 = new IngredientRelated.Recipe(14);
        newRecipe14.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 200, "g", 1, false));
        newRecipe14.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 300, "ml", 1, true));
        newRecipe14.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 5, "unit(regular)", 50, false));
        newRecipe14.addIngredient(new IngredientRelated.Ingredient("Cocoa Powder", 0, 50, "g", 1, false));
        newRecipe14.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 100, "g", 1, false));
        newRecipe14.setDifficultyRating(3.2f);
        newRecipe14.setStarRating(4.0f);
        newRecipe14.setServingSize(6);
        recipeManager.addRecipe(newRecipe14);

        // Recipe 15 (Complex)
        IngredientRelated.Recipe newRecipe15 = new IngredientRelated.Recipe(15);
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 800, "g", 1, false));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 500, "g", 1, false));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1000, "ml", 1, true));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 8, "unit(regular)", 50, false));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 300, "g", 1, false));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Nuts", 0, 200, "g", 1, false));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Honey", 0, 100, "ml", 1, true));
        newRecipe15.addIngredient(new IngredientRelated.Ingredient("Ground Cinnamon", 0, 10, "g", 1, false));
        newRecipe15.setDifficultyRating(4.0f);
        newRecipe15.setStarRating(4.5f);
        newRecipe15.setServingSize(10);
        recipeManager.addRecipe(newRecipe15);

        // Recipe 16 (Simple)
        IngredientRelated.Recipe newRecipe16 = new IngredientRelated.Recipe(16);
        newRecipe16.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 300, "g", 1, false));
        newRecipe16.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 150, "g", 1, false));
        newRecipe16.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 200, "ml", 1, true));
        newRecipe16.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 4, "unit(regular)", 50, false));
        newRecipe16.addIngredient(new IngredientRelated.Ingredient("Baking Powder", 0, 5, "g", 1, false));
        newRecipe16.setDifficultyRating(2.1f);
        newRecipe16.setStarRating(4.0f);
        newRecipe16.setServingSize(6);
        recipeManager.addRecipe(newRecipe16);

        // Recipe 17 (Complex)
        IngredientRelated.Recipe newRecipe17 = new IngredientRelated.Recipe(17);
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 500, "g", 1, false));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 400, "g", 1, false));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1200, "ml", 1, true));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 12, "unit(regular)", 50, false));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 300, "g", 1, false));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 200, "g", 1, false));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 30, "ml", 1, true));
        newRecipe17.addIngredient(new IngredientRelated.Ingredient("Cocoa Powder", 0, 50, "g", 1, false));
        newRecipe17.setDifficultyRating(4.7f);
        newRecipe17.setStarRating(4.2f);
        newRecipe17.setServingSize(8);
        recipeManager.addRecipe(newRecipe17);

        // Recipe 18 (Simple)
        IngredientRelated.Recipe newRecipe18 = new IngredientRelated.Recipe(18);
        newRecipe18.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 400, "g", 1, false));
        newRecipe18.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 200, "g", 1, false));
        newRecipe18.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 300, "ml", 1, true));
        newRecipe18.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 5, "unit(regular)", 50, false));
        newRecipe18.setDifficultyRating(3.5f);
        newRecipe18.setStarRating(3.8f);
        newRecipe18.setServingSize(6);
        recipeManager.addRecipe(newRecipe18);

        // Recipe 19 (Complex)
        IngredientRelated.Recipe newRecipe19 = new IngredientRelated.Recipe(19);
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 600, "g", 1, false));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 300, "g", 1, false));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 1000, "ml", 1, true));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 10, "unit(regular)", 50, false));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Vanilla Extract", 0, 20, "ml", 1, true));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Butter", 0, 150, "g", 1, false));
        newRecipe19.addIngredient(new IngredientRelated.Ingredient("Chocolate Chips", 0, 100, "g", 1, false));
        newRecipe19.setDifficultyRating(4.0f);
        newRecipe19.setStarRating(4.5f);
        newRecipe19.setServingSize(8);
        recipeManager.addRecipe(newRecipe19);

        // Recipe 20 (Simple)
        IngredientRelated.Recipe newRecipe20 = new IngredientRelated.Recipe(20);
        newRecipe20.addIngredient(new IngredientRelated.Ingredient("Flour", 0, 300, "g", 1, false));
        newRecipe20.addIngredient(new IngredientRelated.Ingredient("Sugar", 0, 150, "g", 1, false));
        newRecipe20.addIngredient(new IngredientRelated.Ingredient("Milk", 0, 200, "ml", 1, true));
        newRecipe20.addIngredient(new IngredientRelated.Ingredient("Eggs", 0, 4, "unit(regular)", 50, false));
        newRecipe20.addIngredient(new IngredientRelated.Ingredient("Salt", 0, 5, "g", 1, false));
        newRecipe20.setDifficultyRating(2.1f);
        newRecipe20.setStarRating(4.0f);
        newRecipe20.setServingSize(6);
        recipeManager.addRecipe(newRecipe20);
        // Add more recipes here if needed
    }
}
