package dev.Recipeapi.Recipe;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.util.List;

@Document(collection = "reviews")
@Data  //Create getter and setter
@AllArgsConstructor  //Create  constrcutors
@NoArgsConstructor //Create constructors without arguments
public class Review {
    @Id
    private ObjectId id;
    private String body;

    public Review (String body)
    {
        this.body = body;
    }
}
