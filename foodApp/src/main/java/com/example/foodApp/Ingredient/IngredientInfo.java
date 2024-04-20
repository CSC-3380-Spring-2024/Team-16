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

@Document(collection = "IngredientInfo")
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
    private boolean isCountable;
    public IngredientInfo(String name, int shelfLife, double gramPerUnit, boolean isLiquid) {
        this.name = name;
        this.shelfLife = shelfLife;
        this.gramPerUnit = gramPerUnit;
        this.isLiquid = isLiquid;
    }
    // Getters and setters
    public ObjectId getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public int getShelfLife() {
        return shelfLife;
    }
    public double getGramPerUnit() {
        return gramPerUnit;
    }
    public boolean isLiquid() {
        return isLiquid;
    }
    public boolean isCountable() {
        return isCountable;
    }
}
