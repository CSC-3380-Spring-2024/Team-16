package com.example.foodApp.Comment;

import com.example.foodApp.Post.Post;
import com.example.foodApp.Recipe.Recipe;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private MongoTemplate mongoTemplate;


    public String createComment (String commentBody, String username, ObjectId id)
    {
        Comment comment = commentRepository.insert(new Comment(commentBody,username));

        mongoTemplate.update(Post.class)
                .matching(Criteria.where("_id").is(id))
                .apply(new Update().push("commentIds").value(commentBody)).first();

        return "Sucess";
    }

}

