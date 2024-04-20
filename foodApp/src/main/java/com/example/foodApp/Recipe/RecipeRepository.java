package com.example.foodApp.Recipe;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository //let framework know this is a repository
public interface RecipeRepository extends MongoRepository<Recipe, ObjectId> { //Let people know it is for type Movie with IDs of type ObjectId
    Optional<Recipe> findRecipeByName(String name); //Spring Data MongoDB knows what to do just from the method name alone
}
