package dev.Recipeapi.Recipe;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface RecipeRepository extends MongoRepository<Recipe, ObjectId>
{
    Optional<Recipe> findRecipeByName(String Name);
    List<Recipe> findByIngredientsIn(List<String> ingredients);
}
