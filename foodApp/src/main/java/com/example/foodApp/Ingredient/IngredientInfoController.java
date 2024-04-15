package com.example.foodApp.Ingredient;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.foodApp.Backend.Fuzzy;
import com.example.foodApp.Backend.Ingredient;
import com.example.foodApp.Backend.Pantry;
import com.example.foodApp.Backend.RecipeManager;
import com.example.foodApp.Recipe.Recipe;
import com.example.foodApp.Recipe.RecipeService;

@RestController
@RequestMapping("ingredient")
public class IngredientInfoController {
    @Autowired
    private IngredientInfoService ingredientInfoService;
    @Autowired RecipeService recipeService;

    /*
     * Returns an IngredientInfo object found in the database based on name. Returns null if not found.
     */
    @GetMapping("/{name}")
    public IngredientInfo getIngredientInfoByName(@PathVariable String name) {
        IngredientInfo info = ingredientInfoService.ingredientInfoByName(name);
        System.out.println(name + info);
        return info;
    }
    @PostMapping
    /*
     * This method returns a list of heuristically scored recipes based given pantry information by the client.
     */
    public List<Recipe> recipesFromPantry(@RequestBody Map<String, List<Ingredient>> payload) {
        List<Ingredient> listOfIngredients = payload.get("listOfIngredients");
        //Add each ingredient to Pantry while keeping track of soonest expiring
        int soonestExpiry = 9999;
        String soonestExpiringIngredientName = "Baked Beans";
        Pantry pantry = new Pantry();
        for (Ingredient ingredient : listOfIngredients) {
            ingredient.setIngredientInfo(ingredientInfoService.ingredientInfoByName(ingredient.getName()));
            pantry.addIngredient(ingredient);
            if (ingredient.getExpiry() < soonestExpiry) {
                soonestExpiringIngredientName = ingredient.getName();
            }
        }
        //Get list of Recipes with soonest expiring ingredient
        List<Recipe> recipeList = recipeService.recipesWithIngredient(soonestExpiringIngredientName);

        //Add each recipe to recipeManager & add each of its ingredients to its hashmap
        RecipeManager recipeManager = new RecipeManager();
        for (Recipe recipe : recipeList) {
            for (int i = 0; i < recipe.getIngredients().length; i++) {
                String[] curIng = recipe.getIngredients()[i];
                Ingredient ingredient = new Ingredient(curIng[0], curIng[1], 0);
                ingredient.setIngredientInfo(ingredientInfoService.ingredientInfoByName(curIng[0]));
                recipe.addIngredient(ingredient);
            }
            recipeManager.addRecipe(recipe);
        }
        //TODO: Get serving size
        int servingSize = 4;
        
        List<Map<Double, Recipe>> topRecipes = Fuzzy.findTopScoringRecipes(recipeManager, pantry, servingSize);
        List<Recipe> resultRecipeList = new ArrayList<Recipe>();

        for (Map<Double, Recipe> scoreRecipeMap : topRecipes) {
            for (Recipe recipe : scoreRecipeMap.values()) {
                resultRecipeList.add(recipe);
            }
        }

        return resultRecipeList;
    }
}
