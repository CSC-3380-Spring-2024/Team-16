package dev.Recipeapi.Recipe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class ReviewService
{
    @Autowired
    private ReviewRepository reviewRepo;
    @Autowired
    private MongoTemplate mongoTemplate;

    public Review createReview(String reviewBody, String id)
    {
        Review review1 = reviewRepo.insert(new Review(reviewBody));

        mongoTemplate.update(Recipe.class).matching(Criteria.where("ObjectId").is(id)).apply(new Update().push("Review").value(review1)).first();

        return review1;
    }


}
