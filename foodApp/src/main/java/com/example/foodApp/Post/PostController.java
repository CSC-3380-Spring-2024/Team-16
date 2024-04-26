package com.example.foodApp.Post;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/post")
public class PostController
{
    private ImageConverter imageConverter;
    @Autowired
    private PostService postService;


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

        byte [] binaryImage = imageConverter.base64Tobinary(image);

        if(binaryImage == null )
        {
            return ResponseEntity.unprocessableEntity().body("image conversion failed");
        }

        createPost = postService.createPost(caption,username,referenceId,binaryImage);

        return ResponseEntity.ok(createPost);

    }
}
