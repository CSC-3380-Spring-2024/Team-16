package com.example.foodApp.Comment;

import com.example.foodApp.Review.LikeNDislikeFilter;
import com.example.foodApp.Review.Review;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/comment")
public class CommentController
{
    @Autowired
    private CommentService commentService;
    @Autowired
    private MongoTemplate mongoTemplate;

//    @GetMapping("/comment")
//    public ResponseEntity<String> getallComment (@RequestBody  ObjectId id)
//    {
//
//        return;
//    }

    /**
     * @apiNote
     * local8080/api/comment/create
     * [
     *     "Jonh Doe", // username
     *     "This post is a amazing", // comment
     *     "66233a7b4d364a7c8cc383bb" // valid Post obejctID
     * ]
     * @param payload
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity<String> Createcommment (@RequestBody List<String> payload)
    {
        String username = payload.get(0);
        String commentBody = payload.get(1);
        ObjectId id = new ObjectId(payload.get(2));

        String update = commentService.createComment(commentBody,username,id);

        return ResponseEntity.ok(update);
    }

    /**
     *
     * @apiNote
     * local8080/api/comment/addLike
     * {
     *     id = "66233a7b4d364a7c8cc383bb" // valid Comment ObjectId
     *     username = "Jonh Doe"
     * }
     * @param payload
     * @return
     */

    @PostMapping("/addLike")
    public ResponseEntity<String> addLike (@RequestBody Map<String,String> payload)
    {
        ObjectId commentId = new ObjectId(payload.get("id"));
        String personName = payload.get("username");
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(commentId));
        Comment comment = mongoTemplate.findOne(query, Comment.class);

        List<String> peopleLiked = comment.getLike();
        List<String> peopleDisliked = comment.getDislike();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("like", personName);
        mongoTemplate.updateFirst(query, update, Comment.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }




    /**
     * @apiNote
     * local8080/api/comment/addDislike
     * {
     *     id = "66233a7b4d364a7c8cc383bb" // valid Comment ObjectId
     *     username = "Jonh Doe"
     * }
     * @param payload
     * @return
     */
    @PostMapping("/addDislike")
    public ResponseEntity<String> addDislike (@RequestBody Map<String,String> payload)
    {
        ObjectId commentId = new ObjectId(payload.get("id"));
        String personName = payload.get("username");
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(commentId));
        Comment comment = mongoTemplate.findOne(query, Comment.class);

        List<String> peopleLiked = comment.getLike();
        List<String> peopleDisliked = comment.getDislike();

        LikeNDislikeFilter filtering = new LikeNDislikeFilter(peopleLiked, peopleDisliked);
        boolean filterCheck = filtering.filter(personName);

        if(filterCheck)
        {
            return ResponseEntity.unprocessableEntity().body("You have like or disliked");
        }
        Update update = new Update().addToSet("dislike", personName);
        mongoTemplate.updateFirst(query, update, Comment.class);
        return ResponseEntity.ok("Review Updated Successfully");
    }

}
