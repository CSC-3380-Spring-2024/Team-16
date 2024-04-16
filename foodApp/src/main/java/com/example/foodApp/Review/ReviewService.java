package com.example.foodApp.Review;


import com.example.foodApp.Recipe.Recipe;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {

    @Autowired
    private MongoTemplate mongoTemplate;
    @Autowired
    private ReviewRepository reviewRepository;
    public Review createReview (String reviewBody, String name)
    {
        Review review = reviewRepository.insert(new Review(reviewBody));

         mongoTemplate.update(Recipe.class)
                 .matching(Criteria.where("name").is(name))
                 .apply(new Update().push("reivewId").value(review)).first();

        return review;
    }
}
