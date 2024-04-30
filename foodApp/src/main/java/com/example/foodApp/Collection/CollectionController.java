package com.example.foodApp.Collection;

import com.example.foodApp.System.DistinctId;
import com.example.foodApp.System.ImageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/collection")
public class CollectionController
{

    @Autowired
    private CollectionService collectionService;
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
     *     "distinctId": "", // valid distinctId for
     *     "uploadImage: ""
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