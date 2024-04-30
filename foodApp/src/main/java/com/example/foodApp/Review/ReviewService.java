package com.example.foodApp.Review;


import com.example.foodApp.Recipe.Recipe;
import com.example.foodApp.System.DistinctId;
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
    @Autowired
    private DistinctId distinctId;
    public Review createReview (String header, String reviewBody, String author,String recipeId)
    {
        Review review = reviewRepository.insert(new Review(header,reviewBody,author,distinctId.generateId()));

         mongoTemplate.update(Recipe.class)
                 .matching(Criteria.where("distinctId").is(recipeId))
                 .apply(new Update().push("reivewId").value(review)).first();

        return review;
    }
    
}
