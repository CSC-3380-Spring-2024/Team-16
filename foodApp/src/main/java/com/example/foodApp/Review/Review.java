package com.example.foodApp.Review;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
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
    private String reviewBody;


    public Review(String reviewBody) {
        this.reviewBody = reviewBody;
    }
}

