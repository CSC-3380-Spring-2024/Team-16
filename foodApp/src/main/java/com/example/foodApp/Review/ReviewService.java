package com.example.foodApp.Review;


import com.example.foodApp.Recipe.Recipe;
import com.mongodb.internal.operation.CreateCollectionOperation;

import javax.management.Query;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.CriteriaDefinition;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private ReviewRepository reviewRepository;
    public Review createReview (String header, String reviewBody, String author,String name)
    {
        Review review = reviewRepository.insert(new Review(header,reviewBody,author));

         mongoTemplate.update(Recipe.class)
                 .matching(Criteria.where("name").is(name))
                 .apply(new Update().push("reivewId").value(review)).first();

        return review;
    }
    
}
