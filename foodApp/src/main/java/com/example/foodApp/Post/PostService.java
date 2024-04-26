package com.example.foodApp.Post;

import com.example.foodApp.AccountCreaete.Account;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class PostService
{
    @Autowired
    private PostRespository postRespository;
    @Autowired
    private MongoTemplate mongoTemplate;

    public String createPost (String caption, String username, ObjectId reference, byte[] photoImage)
    {
        if(photoImage != null)
        {
            Post createPost = postRespository.insert(new Post(reference,caption,username,photoImage));

            mongoTemplate.update(Account.class)
                    .matching(Criteria.where("username").is(username))
                    .apply(new Update().push("postIds").value(createPost)).first();
            return "Upload post with Image";
        }
        else
        {
            Post createPost = postRespository.insert(new Post(reference,caption,username));

            mongoTemplate.update(Account.class)
                    .matching(Criteria.where("username").is(username))
                    .apply(new Update().push("postIds").value(createPost)).first();
            return "Upload post without Image";
        }


    }
}
