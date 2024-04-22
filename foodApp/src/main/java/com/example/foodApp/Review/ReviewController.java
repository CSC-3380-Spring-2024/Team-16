package com.example.foodApp.Review;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import com.example.foodApp.Recipe.RecipeController;
import com.example.foodApp.Recipe.RecipeService;

import java.util.List;
import java.util.Map;
import java.util.Optional;



@RestController
@RequestMapping("/api/review")
public class ReviewController {

    @Autowired
    private RecipeService recipeService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private MongoTemplate mongoTemplate;
    /**
     * @apiNote
     * POST /api/review/create HTTP/1.1
        Host: local8080
        Content-Type: application/json

            [
            "Amazing Cheesecake"               // Header
            "This is amazing",                  // reviewBody
            "66259dd4cf6c9bdb66b36f6a",         // Recipe ObjectId
            "John Doe",                         // authorName
            "3"                                 // starRating
            "3"                                 // difficultyRating              
            ] 

     * 
     * @param payload (String reviewBody, recipeName, author, double starRating)
     * @return Write to the database
     */
    @PostMapping("/create")
    public ResponseEntity<Review> createReview(@RequestBody List<String> payload) {
        if (payload.size()!= 6) {
            return ResponseEntity.badRequest().build();
        }
        
        String header = payload.get(0);
        String reviewBody = payload.get(1);
        ObjectId recipeId = new ObjectId(payload.get(2));
        String author = payload.get(3);
        double starRating = Double.parseDouble(payload.get(4));
        double difficultyRating = Double.parseDouble(payload.get(5));

        // calling adding starRating and diffcultyRating from recipeController
            recipeService.starRating(starRating, recipeId);
            recipeService.difficultyRating(difficultyRating, recipeId);


        Review createdReview = reviewService.createReview(header,reviewBody,author, recipeId);
        return new ResponseEntity<>(createdReview, HttpStatus.OK);
    }
    /**
     * @apiNote 
     * POST /api/reviews/addLike HTTP/1.1
        Host: yourapi.com
        Content-Type: application/json
     *  {
            "id": "661ee97695691a0bdeed4cb4",  // Review ObjectId
            "personName": "Jonh Doe"
        }
     * 
     * @param payload
     * @return addlike to the reviewer
     */

    @PostMapping("/addLike")
    public ResponseEntity<String> addLike (@RequestBody Map<String,String> payload)
     {
        ObjectId reviewId = new ObjectId(payload.get("id"));
        String personName = payload.get("personName");

        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(reviewId));
        Review review = mongoTemplate.findOne(query, Review.class);

        List<String> peopleLiked = review.getPeopleLiked();
        List<String> peopleDisliked = review.getPeopleDisliked();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("peopleLiked", personName);
        mongoTemplate.updateFirst(query, update, Review.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }

    /**
     * @apiNote
     *  http://localhost:8080/api/review/addDislike
     * {
     *  "id": "661ee97695691a0bdeed4cb4" // valid ObjectID
     *  "username": "Jonh Doe"
     *
     * }
     * @param payload
     * @return addDislike to the reviewer
     */

    @PostMapping("/addDislike")
    public ResponseEntity<String> addDislike(@RequestBody Map<String,String> payload)
    {
        ObjectId reviewId = new ObjectId(payload.get("id"));
        String personName = payload.get("username");

        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(reviewId));
        Review review = mongoTemplate.findOne(query, Review.class);

        List<String> peopleLiked = review.getPeopleLiked();
        List<String> peopleDisliked = review.getPeopleDisliked();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("peopleDisliked", personName);
        mongoTemplate.updateFirst(query, update, Review.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }
    
    
}
