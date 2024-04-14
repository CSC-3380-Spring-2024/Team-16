package com.example.foodApp.Ingredient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service
public class IngredientInfoService {
    @Autowired
    private MongoTemplate mongoTemplate;

    /*
     * Gets the Ingredient Info from the database by name. Returns null if none is found.
     */
    public IngredientInfo ingredientInfoByName(String name) {
        Query query = new Query();
        query.addCriteria(Criteria.where("name").in(name));
        try {
            return mongoTemplate.find(query, IngredientInfo.class).getFirst();
        } catch(Exception e) {
            return null;
        }
    }
}
