package com.example.foodApp.Ingredient;

import com.example.foodApp.Backend.Ingredient;
import com.example.foodApp.Ingredient.IngredientInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static java.util.Arrays.asList;

@Service
public class IngredientInfoService {
    @Autowired
    private MongoTemplate mongoTemplate;
    /*
     * Gets the Ingredient Info from the database by name. Returns null if none is found.
     */
    public IngredientInfo ingredientInfoByName(String name) {
        Query query = new Query();
        query.addCriteria(Criteria.where("name").is(name));
        try {
            return mongoTemplate.find(query, IngredientInfo.class).get(0);
        } catch(Exception e) {
            return null;
        }
    }
    public List<String> similarIngredientInfo(IngredientInfo ingredientInfo) {
        // STUB: TODO: Implement the logic for similarityTable
        String similarityTable = ingredientInfo.getSimilarityTable(); // Assuming there's a method to get similarityTable

        if (similarityTable == "") {
            return null; // Return an empty list if similarityTable is empty
        }

        // Assuming you have a method to retrieve similarityTable from MongoDB
        List<String> matchingStrings = retrieveStrings(similarityTable);

        return matchingStrings;
    }

    private List<String> retrieveStrings(String similarityTable) {
        // Implement logic to retrieve matching strings from MongoDB based on similarityTable
        // You can use mongoTemplate or any other method to query the database
        // For now, let's return an empty list as a placeholder
        if (similarityTable == "") return null;
        return Arrays.asList("Carrot", "Beetroot", "Turnip", "Radish", "Parsnip", "Rutabaga", "Horseradish");
    }
}
