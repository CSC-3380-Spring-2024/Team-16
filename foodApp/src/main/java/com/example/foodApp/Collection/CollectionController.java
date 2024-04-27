package com.example.foodApp.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

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
     * @param collectionsAndName
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity<String> createCollection (@RequestBody CollectionAndUserName collectionsAndName)
    {
        String username = collectionsAndName.getUsername();
        Collection collection = collectionsAndName.getCollection();
        // image converter === when merge with Post

        String result = collectionService.createCollection(collection,username);

        return ResponseEntity.ok(result);

    }

}