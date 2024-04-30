package com.example.foodApp.Collection;

import com.example.foodApp.AccountCreaete.Account;
import com.example.foodApp.System.DistinctId;
import com.example.foodApp.System.ImageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.ldap.embedded.EmbeddedLdapProperties;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

@Service
public class CollectionService {
    @Autowired
    private CollectionRepository collectionRepository;
    @Autowired
    private DistinctId distinctId;
    @Autowired
    private MongoTemplate mongoTemplate;


    public String createCollection(Collection collections, String username) {
        String result = "";
        Collection collection;
        String collectionId = distinctId.generateId();
        collection = collectionRepository.insert(new Collection(collections.getRecipeId(), collections.getCollectionName(), collectionId));
            result = "Upload without Image";
            mongoTemplate.update(Account.class)
                    .matching(Criteria.where("username").is(username))
                    .apply(new Update().push("collectionId").value(collection.getId())).first();
        return result;
    }
    public String addCollectionImage (String distinctId, String imageFile)
    {
        Query query = new Query();

        byte [] image = ImageConverter.base64Tobinary(imageFile);

        query.addCriteria(Criteria.where("distinctId").is(distinctId));
        Collection collection = mongoTemplate.findOne(query,Collection.class);
        Update update = new Update().addToSet("image",image);
        mongoTemplate.updateFirst(query, update,Collection.class);
       return "Image Upload Sucessfully";

    }
}
