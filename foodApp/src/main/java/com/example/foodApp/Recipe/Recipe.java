package com.example.foodApp.Recipe;

import com.example.foodApp.Backend.Ingredient;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Document(collection = "Recipe")
@Data               //generates getters and setters
@AllArgsConstructor 
@NoArgsConstructor
public class Recipe {
    @Id
    private ObjectId id;        //MongoDB internal ObjectId
    private String name;
    private double starRating;       // Star rating out of 5
    private double difficultyRating; // Difficulty Rating out of 5
    private int servingSize;
    private List<String> method;
    private byte [] uploadImage;
    private String youtubeVid;
    private String description;
    private String backdrop;
    private int peopleReviewed;

    // Serving size that the recipe produces
     // Tells database to store only the Ids of ingredients
    @Field("ingredients")
    private String[][] ingredients;
    private Map<String, Ingredient> ingredientsHash = new HashMap<String, Ingredient>();

    public Recipe(ObjectId id) {
        this.id = id;
        ingredientsHash = new HashMap<>();
    }

    // Method to add an ingredient to the recipe
    public void addIngredient(Ingredient ingredient) {
        ingredientsHash.put(ingredient.getName(), ingredient);
    }

    // Method to get an ingredient from the recipe
    public Ingredient getIngredient(String ingredientName) {
        return ingredientsHash.get(ingredientName);
    }

    // Method to get all ingredients in the recipe
    public Map<String, Ingredient> getAllIngredients() {
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
    public double getStarRating() {
        return starRating;
    }

    // Method to get the star rating of the recipe
    public double getDifficultyRating() {
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
            //IngredientRelated related = new IngredientRelated();
            Ingredient ingredient = new Ingredient(name, quantity, 0);
            
            // Add the ingredient to the ingredientsHash map
            ingredientsHash.put(name, ingredient);
        }
    }
}
