package com.example.foodApp.Recipe;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RecipeService {
    @Autowired // tells framework to instantiate this class
    private RecipeRepository recipeRepository;

    public List<Recipe> allRecipes() {
        return recipeRepository.findAll();
    }
    public Optional<Recipe> recipeByName(String name) { // Optional class lets Java know the fn can return null if no document is found
        return recipeRepository.findRecipeByName(name);
    }
}