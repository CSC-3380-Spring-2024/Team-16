/*
 * Makei Salmon
 */
package com.example.foodApp.Ingredient;

import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Document
@Data
@NoArgsConstructor
@AllArgsConstructor
public class IngredientInfo {
    @Id
    private ObjectId id;
    private String name;        //name of ingredient
    private int shelfLife;      //shelf life in days
    private double gramPerUnit; //unit weight
    private boolean isLiquid;  
}
