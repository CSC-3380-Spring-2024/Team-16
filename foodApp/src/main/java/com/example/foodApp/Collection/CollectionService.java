package com.example.foodApp.Collection;

import com.example.foodApp.AccountCreaete.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class CollectionService {
    @Autowired
    private CollectionRepository collectionRepository;
    @Autowired
    private MongoTemplate mongoTemplate;


    public String createCollection(Collection collections, String username) {
        String result = "";
        Collection collection;

        byte[] image = collections.getImage();
        if (image == null || collections.getImageFormat() == null) {
            collection = collectionRepository.insert(new Collection(collections.getRecipeId(), collections.getCollectionName()));
            result = "Upload without Image";
        } else {
            collection = collectionRepository.insert(new Collection(collections.getRecipeId(), collections.getCollectionName(), collections.getImage(), collections.getImageFormat()));
            result = "Upload with Image";
        }

        if (collection != null) {
            mongoTemplate.update(Account.class)
                    .matching(Criteria.where("username").is(username))
                    .apply(new Update().push("collectionId").value(collection.getId())).first();
        }

        return result;
    }
}
