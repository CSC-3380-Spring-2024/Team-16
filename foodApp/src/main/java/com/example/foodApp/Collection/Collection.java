package com.example.foodApp.Collection;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "Collection")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Collection {

    @Id
    private ObjectId id;
    private List<ObjectId> recipeId;
    private String collectionName;
    private byte [] image;
    private String imageFormat;

    public Collection (List<ObjectId> recipeId, String name)
    {
        this.collectionName = name;
        this.recipeId = recipeId;
        this.image = null;
        this.imageFormat = null;
    }
    public Collection (List<ObjectId> recipeId, String name, byte [] image, String imageFormat)
    {
        this.collectionName = name;
        this.recipeId = recipeId;
        this.image = image;
        this.imageFormat = imageFormat;
    }
}
