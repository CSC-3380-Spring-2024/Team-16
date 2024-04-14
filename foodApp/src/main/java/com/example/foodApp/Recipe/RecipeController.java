package com.example.foodApp.Recipe;

import java.util.List;
//import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("recipe")
public class RecipeController {
    @Autowired
    private RecipeService recipeService;
    @GetMapping
    public ResponseEntity<List<Recipe>> getAllRecipes() {
        System.out.println("ALL RUNNING");
        return new ResponseEntity<List<Recipe>>(recipeService.allRecipes(), HttpStatus.OK);
    }
    @GetMapping("/{name}")
    public ResponseEntity<List<Recipe>> getRecipesWithIngredient(@PathVariable String name) {
        System.out.println("it work");
        return new ResponseEntity<List<Recipe>>(recipeService.recipesWithIngredient(name), HttpStatus.OK);
    }
}
