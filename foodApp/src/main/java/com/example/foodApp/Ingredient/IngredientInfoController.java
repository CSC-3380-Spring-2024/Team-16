package com.example.foodApp.Ingredient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("ingredient")
public class IngredientInfoController {
    @Autowired
    private IngredientInfoService ingredientInfoService;

    /*
     * Returns an IngredientInfo object found in the database based on name. Returns null if not found.
     */
    @GetMapping("/{name}")
    public IngredientInfo getIngredientInfoByName(@PathVariable String name) {
        IngredientInfo info = ingredientInfoService.ingredientInfoByName(name);
        System.out.println(name + info);
        return info;
    }
}
