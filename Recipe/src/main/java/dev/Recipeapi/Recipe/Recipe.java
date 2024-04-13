package dev.Recipeapi.Recipe;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "recipe")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Recipe {
    @Id
    private ObjectId id;
    private String Name;
    private String url;
    private String Description;
    private String Author;
    private List<String> Ingredients;
    private List<String> Method;
    private List <String> Review;






}
