package com.example.foodApp.Review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.foodApp.Recipe.RecipeController;
import com.example.foodApp.Recipe.RecipeService;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {

    @Autowired
    private RecipeService recipeService;
    @Autowired
    private ReviewService reviewService;
    /**
     * @apiNote
     * POST /reviews HTTP/1.1
        Host: yourapi.com
        Content-Type: application/json

            [
            "Amazing Cheesecake"               // Header
            "This is amazing",                  // reviewBody
            "Cheesecake",                        // recipeName
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
        String recipeName = payload.get(2);
        String author = payload.get(3);
        double starRating = Double.parseDouble(payload.get(4));
        double difficultyRating = Double.parseDouble(payload.get(5));

        // calling adding starRating and diffcultyRating from recipeController
            recipeService.starRating(starRating, recipeName);
            recipeService.difficultyRating(difficultyRating, recipeName);


        reviewBody = ProfanityFilter.filterText(reviewBody);

        Review createdReview = reviewService.createReview(header,reviewBody,author, recipeName);
        return new ResponseEntity<>(createdReview, HttpStatus.OK);
    }
}
