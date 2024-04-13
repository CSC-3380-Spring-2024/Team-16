package dev.Recipeapi.Recipe;

import com.fasterxml.jackson.databind.annotation.JsonAppend;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class RecipeController {

    @Autowired
    private RecipeService recipeService;
    @GetMapping("/api/recipe")
    public ResponseEntity<List<Recipe>> allRecipe()
    {
        return new ResponseEntity<List<Recipe>>(recipeService.allRecipe(), HttpStatus.OK);
    }
    @GetMapping("/{Id}")
    public ResponseEntity<Optional<Recipe>> getRecipe (@PathVariable ObjectId Id)
    {
        return new ResponseEntity<Optional<Recipe>>(recipeService.aRecipe(Id), HttpStatus.OK);
    }
    @GetMapping("/api/recipes/search")
    public ResponseEntity<List<Recipe>> searchRecipesByIngredients(@RequestParam List<String> ingredients)
    {
        List<Recipe> recipes = recipeService.findRecipesByIngredients(ingredients);
        return ResponseEntity.ok(recipes);
    }
}
