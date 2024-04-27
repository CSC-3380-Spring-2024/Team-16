package com.example.foodApp.Post;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

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
    private List<String> disLike;
    private byte[] uploadImage;
    private String imageFormat;

    public Post (ObjectId reference, String caption, String username, byte [] uploadImage,String imageFormat)
    {
        this.reference = reference;
        this.caption = caption;
        this.username = username;
        this.uploadImage = uploadImage;
        this.imageFormat = imageFormat;
    }

    public Post(ObjectId reference, String caption, String username)
    {
        this.reference = reference;
        this.caption = caption;
        this.username = username;
    }
}
