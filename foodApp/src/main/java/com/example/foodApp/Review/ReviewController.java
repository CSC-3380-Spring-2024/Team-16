package com.example.foodApp.Review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;
    @PostMapping
    public ResponseEntity<Review> createReview(@RequestBody Map<String, String> payload) {
        String reviewBody = payload.get("reviewBody");
        String name = payload.get("name");

        if (reviewBody == null || reviewBody.isEmpty() || name == null || name.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        reviewBody = ProfanityFilter.filterText(reviewBody);

        Review createdReview = reviewService.createReview(reviewBody, name);
        return new ResponseEntity<>(createdReview, HttpStatus.OK);
    }
}
