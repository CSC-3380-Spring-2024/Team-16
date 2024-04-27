package com.example.foodApp.Post;

import com.example.foodApp.AccountCreaete.Account;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PostService
{
    @Autowired
    private PostRespository postRespository;
    @Autowired
    private MongoTemplate mongoTemplate;


    public List<Post> getAllPostsRanked() {
        List<Post> allPosts = postRespository.findAll();
        allPosts.sort((post1, post2) -> {

            int score1 = (post1.getLike() != null ? post1.getLike().size() : 0)
                    - (post1.getDisLike() != null ? post1.getDisLike().size() : 0);


            int score2 = (post2.getLike() != null ? post2.getLike().size() : 0)
                    - (post2.getDisLike() != null ? post2.getLike().size() : 0);

            return score2 - score1;
        });
        return allPosts;
    }

    public String createPost (String caption, String username, ObjectId reference, byte[] photoImage, String imageFormat)
    {
        if(photoImage != null && imageFormat != null)
        {
            Post createPost = postRespository.insert(new Post(reference,caption,username,photoImage,imageFormat));

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
