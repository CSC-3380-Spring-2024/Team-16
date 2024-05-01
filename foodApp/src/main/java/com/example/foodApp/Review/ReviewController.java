 package com.example.foodApp.Review;

 import com.example.foodApp.Comment.Comment;
 import com.example.foodApp.System.LikeNDislikeFilter;
 import org.bson.types.ObjectId;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.data.mongodb.core.MongoTemplate;
 import org.springframework.data.mongodb.core.query.Criteria;
 import org.springframework.http.HttpStatus;
 import org.springframework.http.ResponseEntity;
 import org.springframework.web.bind.annotation.*;
 import org.springframework.data.mongodb.core.query.Query;
 import org.springframework.data.mongodb.core.query.Update;

 import com.example.foodApp.Recipe.RecipeService;

 import java.util.List;
 import java.util.Map;


 @RestController
 @CrossOrigin(origins = "*")
@RequestMapping("/api/review")
public class ReviewController {

    @Autowired
    private RecipeService recipeService;
    @Autowired
    private ReviewService reviewService;
    @Autowired
    private MongoTemplate mongoTemplate;

     @GetMapping("/getReview")
     public ResponseEntity<List<Review>> getComment(@RequestBody String recipeId) {

         Query query = new Query();

         query.addCriteria(Criteria.where("recipeId").is(recipeId));


         List<Review> reviews = mongoTemplate.find(query, Review.class);


         return ResponseEntity.ok(reviews);
     }

    /**
     * @apiNote
     * POST /api/review/create HTTP/1.1
        Host: local8080
        Content-Type: application/json

            [
            "Amazing Cheesecake"               // Header
            "This is amazing",                  // reviewBody
            "0a737ed7-fa83-4695-9ea9-1bf55d8aa457",         // Recipe distinctId
            "John Doe",                         // authorName
            "3"                                 // starRating
            "3"                                 // difficultyRating
            ]

//      *
//      * @param payload (String reviewBody, recipeName, author, double starRating)
//      * @return Write to the database
//      */


     @PostMapping("/create")
     public ResponseEntity<Review> createReview(@RequestBody List<String> payload) {
         if (payload.size()!= 6) {
             return ResponseEntity.badRequest().build();
         }

        String header = payload.get(0);
        String reviewBody = payload.get(1);
        String recipeId = payload.get(2);
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
            "id": "661ee97695691a0bdeed4cb4",  // Review distinctId
            "personName": "Jonh Doe"
        }
     *
     * @param payload
     * @return addlike to the reviewer
     */

    @PostMapping("/addLike")
    public ResponseEntity<String> addLike (@RequestBody Map<String,String> payload)
    {
        String reviewId =payload.get("id");
        String personName = payload.get("username");
         Query query = new Query();
         query.addCriteria(Criteria.where("distinctId").is(reviewId));
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
     *  "id": "661ee97695691a0bdeed4cb4" // review distinctId
     *  "username": "Jonh Doe"
     *
     * }
     * @param payload
     * @return addDislike to the reviewer
     */

    @PostMapping("/addDislike")
    public ResponseEntity<String> addDislike(@RequestBody Map<String,String> payload)
    {
        String reviewId = payload.get("id");
        String personName = payload.get("username");
        Query query = new Query();
        query.addCriteria(Criteria.where("distinctId").is(reviewId));

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
