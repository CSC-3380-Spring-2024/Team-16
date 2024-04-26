package com.example.foodApp.Post;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;
import java.util.Optional;

@Document(collection = "Post")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Post
{
    @Id
    ObjectId id;
    private ObjectId reference;
    private String caption;
    private String username;
    private List<String> like;
    private byte[] uploadImage;

    public Post (ObjectId reference, String caption, String username, byte [] uploadImage)
    {
        this.reference = reference;
        this.caption = caption;
        this.username = username;
        this.uploadImage = uploadImage;
    }

    public Post(ObjectId reference, String caption, String username)
    {
        this.reference = reference;
        this.caption = caption;
        this.username = username;
    }
}
