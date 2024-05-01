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
    private String reference;
    private String caption;
    private String username;
    private String distinctId;
    private List<String> like;
    private List<String> disLike;
    private byte[] uploadImage;
    private String imageFormat;
    private List<String> commentIds;


    public Post ( String reference, String caption, String username, byte [] uploadImage,String imageFormat, String distinctId )
    {
        this.reference = reference;
        this.caption = caption;
        this.distinctId = distinctId;
        this.username = username;
        this.uploadImage = uploadImage;
        this.imageFormat = imageFormat;
    }

    public Post(String reference, String caption, String username, String distinctId)
    {
        this.reference = reference;
        this.caption = caption;
        this.username = username;
        this.distinctId = distinctId;

    }
}
