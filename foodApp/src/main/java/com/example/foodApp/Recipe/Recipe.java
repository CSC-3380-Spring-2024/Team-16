package com.example.foodApp.Recipe;

import java.util.HashMap;
import java.util.Map;
///import java.util.Map;

import com.example.foodApp.Backend.IngredientRelated;
import com.example.foodApp.Backend.IngredientRelated.*;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
//import org.springframework.data.mongodb.core.mapping.DocumentReference;
import org.springframework.data.mongodb.core.mapping.Field;

//import com.example.foodApp.Ingredient.IngredientInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document(collection = "Recipe")
@Data               //generates getters and setters
@AllArgsConstructor 
@NoArgsConstructor
public class Recipe {
    @Id
    private ObjectId id;        //MongoDB internal ObjectId
    private String name;
    private float starRating;       // Star rating out of 5
    private float difficultyRating; // Difficulty Rating out of 5
    private int servingSize;        // Serving size that the recipe produces
     // Tells database to store only the Ids of ingredients
    @Field("ingredients")
    private String[][] ingredients;
    private Map<String, IngredientRelated.Ingredient> ingredientsHash;

    public Recipe(ObjectId id) {
        this.id = id;
        ingredientsHash = new HashMap<>();
    }

    // Method to add an ingredient to the recipe
    public void addIngredient(IngredientRelated.Ingredient ingredient) {
        ingredientsHash.put(ingredient.getName(), ingredient);
    }

    // Method to get an ingredient from the recipe
    public IngredientRelated.Ingredient getIngredient(String ingredientName) {
        return ingredientsHash.get(ingredientName);
    }

    // Method to get all ingredients in the recipe
    public Map<String, IngredientRelated.Ingredient> getAllIngredients() {
        return ingredientsHash;
    }

    // Method to clear all ingredients from the recipe
    public void clearIngredients() {
        ingredientsHash.clear();
    }

    // Method to get the database ID of the recipe
    public ObjectId getId() {
        return id;
    }
    // Method to get the star rating of the recipe
    public float getStarRating() {
        return starRating;
    }

    // Method to get the star rating of the recipe
    public float getDifficultyRating() {
        return difficultyRating;
    }

    // Method to get the serving size of the recipe
    public int getServingSize() {
        return servingSize;
    }

    public void addAllIngredientsFromArray(String[][] ingredientsArray) {
        for (String[] ingredientData : ingredientsArray) {
            // Assuming the structure of ingredientsArray is {name, quantity}
            String name = ingredientData[0];
            String quantity = ingredientData[1];
            
            // Create an Ingredient object
            Ingredient ingredient = new Ingredient(name, quantity, 0);
            
            // Add the ingredient to the ingredientsHash map
            ingredientsHash.put(name, ingredient);
        }
    }
}
