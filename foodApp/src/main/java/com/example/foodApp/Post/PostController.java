package com.example.foodApp.Post;

import com.example.foodApp.Review.LikeNDislikeFilter;
import com.example.foodApp.Review.Review;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/post")
public class PostController
{
    private ImageConverter imageConverter;
    @Autowired
    private PostService postService;
    @Autowired
    private MongoTemplate mongoTemplate;



    @GetMapping("/getAll")
    public ResponseEntity<List<Post>> allPost()
    {
        return new ResponseEntity<List<Post>>(postService.getAllPostsRanked(),HttpStatus.OK);
    }

    /**
     * @apiNote
     * local:8080/api/post/create
     * [
     * "Jonh Doe",
     * "This Recipe is amazing" ,
     * "66259dd4cf6c9bdb66b36f6a" // valid Recipe ObejctId
     * ]
     * @param payload
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity<String> createPost (@RequestBody List<String> payload)
    {
        String createPost;
        String username = payload.get(0);
        String caption = payload.get(1);
        ObjectId referenceId = new ObjectId(payload.get(2));

        if(payload.size() != 4)
        {
             createPost = postService.createPost(caption,username,referenceId,null);
            return ResponseEntity.ok(createPost);
        }
            String image = payload.get(4);

            byte[] binaryImage = imageConverter.base64Tobinary(image);

            if (binaryImage == null) {
                return ResponseEntity.unprocessableEntity().body("image conversion failed");
            }

            createPost = postService.createPost(caption, username, referenceId, binaryImage);

            return ResponseEntity.ok(createPost);


    }
    @PostMapping("/addLike")
    public ResponseEntity<String> addLike (@RequestBody Map<String,String> payload)
    {
        ObjectId postId = new ObjectId(payload.get("id"));
        String personName = payload.get("username");
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(postId));
        Post post = mongoTemplate.findOne(query, Post.class);

        List<String> peopleLiked = post.getLike();
        List<String> peopleDisliked = post.getDisLike();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("like", personName);
        mongoTemplate.updateFirst(query, update, Post.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }
    @PostMapping("/addDislike")
    public ResponseEntity<String> addDislike (@RequestBody Map<String,String> payload)
    {
        ObjectId postId = new ObjectId(payload.get("id"));
        String personName = payload.get("username");
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(postId));
        Post post = mongoTemplate.findOne(query, Post.class);

        List<String> peopleLiked = post.getLike();
        List<String> peopleDisliked = post.getDisLike();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("dislike", personName);
        mongoTemplate.updateFirst(query, update, Post.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }
}
