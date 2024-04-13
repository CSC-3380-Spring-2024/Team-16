package dev.Recipeapi.Recipe;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RecipeService
{
    @Autowired
    private RecipeRepository recipeRepo;
    public List<Recipe> allRecipe()
    {
        return recipeRepo.findAll();
    }
    public Optional<Recipe> aRecipe(ObjectId id)
    {
        return recipeRepo.findById(id);
    }
    public List<Recipe> findRecipesByIngredients(List<String> ingredients)
    {
        return recipeRepo.findByIngredientsIn(ingredients);
    }
}
