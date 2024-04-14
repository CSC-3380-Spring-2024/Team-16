package com.example.foodApp.Recipe;

//import java.util.List;
//import java.util.Map;

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
}
