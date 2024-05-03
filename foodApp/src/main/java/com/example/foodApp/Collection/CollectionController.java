package com.example.foodApp.Collection;

import com.example.foodApp.Review.Review;
import com.example.foodApp.System.DistinctId;
import com.example.foodApp.System.ImageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/collection")
@CrossOrigin(origins = "*")
public class CollectionController
{

    @Autowired
    private CollectionService collectionService;
    @Autowired
    private MongoTemplate mongoTemplate;



    @GetMapping("/getCollection")
    public ResponseEntity<List<Collection>> getCollection (String username)
    {
        Query query = new Query();

        query.addCriteria(Criteria.where("username").is(username));


        List<Collection> colllection = mongoTemplate.find(query, Collection.class);


        return ResponseEntity.ok(colllection);
    }
    /**
     * @apiNote
     * http://localhost:8080/api/collection/create
     *{
     *     "collection":{
     *         "collectionName":"Favorite",  // name of the Collection
     *         "recipeId": [ "66259dd4cf6c9bdb66b36f6a","66259dd4cf6c9bdb66b36f6b"] // valid List of recipe ObjectID
     *     },
     *     "username": "Jonh Doe" // userName
     * }
     * @param payload
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity<String> createCollection (@RequestBody CollectionNUsername payload)
    {
        String username  = payload.getUsername();;
        Collection collection = payload.getCollection();



        String result = collectionService.createCollection(collection,username);

        return ResponseEntity.ok(result);

    }

    /**
     * @apiNote
     * http://localhost:8080/api/collection/addImage
     *
     * {
     *     "distinctId": "dufhgqiuehqe-fgdgrf-bwg-wr", // valid distinctId for
     *     "uploadImage: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAC..."
     * }
     * @param paylaod
     * @return
     */
    @PostMapping("/addImage")
    public ResponseEntity<String> imageCollection (@RequestBody Map<String,String> paylaod)
    {
        String distinctId = paylaod.get("distinctId");
        String imagebase64 = paylaod.get("uploadImage");


        String uploadImage = collectionService.addCollectionImage(distinctId,imagebase64);

        return ResponseEntity.ok(uploadImage);
    }


}