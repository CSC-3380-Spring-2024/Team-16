package com.example.foodApp.Review;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "reviews")
@NoArgsConstructor
@AllArgsConstructor
@Data

public class Review {
    @Id
    private ObjectId id;
    private String header;
    private String reviewBody;
    private String author; 
    private List<String> peopleLiked;
    private List<String> peopleDisliked;

     



    public Review(String header,String reviewBody,String author) {
        this.reviewBody = reviewBody;
        this.author = author;
        this.header = header;
        
    }
}

