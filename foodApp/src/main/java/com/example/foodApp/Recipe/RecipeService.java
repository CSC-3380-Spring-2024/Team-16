package com.example.foodApp.Recipe;

import com.example.foodApp.AccountCreaete.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static org.springframework.data.mongodb.core.query.Criteria.where;
import static org.springframework.data.mongodb.core.query.Query.query;

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
        query.addCriteria(where("ingredients").elemMatch(where("0").is(name))).limit(30);
        List<Recipe> found = mongoTemplate.find(query, Recipe.class);
        System.out.println(found.size());
        return found;
    }


    public Recipe addRecipe (Recipe recipe, String username)
    {
        if(recipe.getName() == null || recipe.getIngredients() == null)
        {
            return null;
        }
        else
        {
            Recipe recipe1 = recipeRepository.insert(recipe);
            mongoTemplate.update(Account.class)
                    .matching(Criteria.where("username").is(username))
                    .apply(new Update().push("postId").value(recipe)).first();

            return recipe1;
        }
    }
    public String addImage (byte [] image, String recipeName)
    {

        Query query = new Query();
        mongoTemplate.update(Recipe.class)
                .matching(query(where("name").is(recipeName)))
                .apply(new Update().set("uploadImage", image))
                .first();

        return "upload Sucess";
    }

    public String starRating (double star, String name)
    {
        Query query = new Query();
        query.addCriteria(where("name").is(name));
        Recipe recipe = mongoTemplate.findOne(query, Recipe.class);
        if(recipe == null)
        {
            return null;
        }
        else
        {
            double prevRating = recipe.getStarRating();
            //List<String> reviewId =  recipe.getReviewId();
            int prevPeopleReviewed = recipe.getPeopleReviewed();
            
            int peopleReviewed = 1;


        
        System.out.println(prevRating);
        
            double averageRating = ((prevRating * prevPeopleReviewed) + (star))/(prevPeopleReviewed +peopleReviewed);

            mongoTemplate.updateFirst(query, Update.update("starRating", averageRating), Recipe.class);
            

            return "Sucess";
        }


    }
    public String difficultyRating (double star, String name)
    {
        Query query = new Query();
        query.addCriteria(where("name").is(name));
        Recipe recipe = mongoTemplate.findOne(query, Recipe.class);
        if(recipe == null)
        {
            return null;
        }
        else
        {
            double prevRating = recipe.getDifficultyRating();
            
            int prevPeopleReviewed = recipe.getPeopleReviewed();

            int peopleReviewed = 1;

            

            double averageRating = ((prevRating * prevPeopleReviewed) + (star))/(prevPeopleReviewed + peopleReviewed);
            
            peopleReviewed += prevPeopleReviewed;

            mongoTemplate.updateFirst(query, Update.update("difficultyRating", averageRating), Recipe.class);
            mongoTemplate.updateFirst(query, Update.update("peopleReviewed", peopleReviewed), Recipe.class);
            return "Sucess";
        }
    }

}