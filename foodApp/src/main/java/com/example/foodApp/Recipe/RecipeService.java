package com.example.foodApp.Recipe;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;

@Service
public class RecipeService {
    @Autowired // tells framework to instantiate this class
    private RecipeRepository recipeRepository;
    @Autowired
    private MongoTemplate mongoTemplate;

    public List<Recipe> allRecipes() {
        return recipeRepository.findAll();
    }
    public Optional<Recipe> recipeByName(String name) { // Optional class lets Java know the fn can return null if no document is found
        return recipeRepository.findRecipeByName(name);
    }

    public List<Recipe> recipesWithIngredient(String name) {
        Query query = new Query();
        query.addCriteria(Criteria.where("ingredients").elemMatch(Criteria.where("0").is(name)));
        return mongoTemplate.find(query, Recipe.class);
    }

    /* We can use this in the Ingredient controller to find ingredients by name !!!! !! !!!!!! 1!!!!!
    public List<Recipe> recipesWithIngredient(String name) {
        Query query = new Query();
        query.addCriteria(Criteria.where("name").in(name));
        return mongoTemplate.find(query, Recipe.class);
    }
     */

    public Recipe addRecipe (Recipe recipe)
    {
        if(recipe.getName() == null || recipe.getIngredients() == null)
        {
            return null;
        }
        else
        {
            return mongoTemplate.insert(recipe);
        }
    }
}