package com.example.foodApp.Recipe;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
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

    public String starRating (float star, String name)
    {
        Query query = new Query();
        query.addCriteria(Criteria.where("name").is(name));
        Recipe recipe = mongoTemplate.findOne(query, Recipe.class);
        if(recipe == null)
        {
            return null;
        }
        else
        {
            double prevRating = recipe.getStarRating();
            List<String> reviewId =  recipe.getReviewId();
            int peopleReviewed = reviewId != null ? reviewId.size(): 0;

            if(peopleReviewed == 0)
            {
                peopleReviewed = 1;
            }

            int averageRating = (int) ((prevRating+star)/peopleReviewed);

            if(averageRating > 5)
            {
                averageRating = 5;
            }

            mongoTemplate.updateFirst(query, Update.update("starRating", averageRating), Recipe.class);

            return "Sucess";
        }

    }
}