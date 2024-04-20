package com.example.foodApp.Recipe;

import lombok.Data;

@Data

public class RecipeAndUsernameRequest {
    private Recipe recipe;
    private String username;

}
