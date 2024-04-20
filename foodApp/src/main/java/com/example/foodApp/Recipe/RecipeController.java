package com.example.foodApp.Recipe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Base64;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/recipe")
public class RecipeController {
    @Autowired
    private RecipeService recipeService;






    //GetMapping
    @GetMapping
    public ResponseEntity<List<Recipe>> getAllRecipes() {
        System.out.println("ALL RUNNING");
        return new ResponseEntity<List<Recipe>>(recipeService.allRecipes(), HttpStatus.OK);
    }
    @GetMapping("/{name}")
    public ResponseEntity<List<Recipe>> getRecipesWithIngredient(@PathVariable String name) {
        System.out.println("it work");
        return new ResponseEntity<List<Recipe>>(recipeService.recipesWithIngredient(name), HttpStatus.OK);
    }















   //PostMapping

    /**
     * @apiNote
     *http://localhost:8080/api/recipe/add
     * {
     *   "name": "Classic Cheesecake",
     *   "starRating": 4.8,
     *   "difficultyRating": 3.5,
     *   "servingSize": 12,
     *   "ingredients": [
     *     ["Cream Cheese", "1 kg"],
     *     ["Sugar", "150 g"],
     *     ["Eggs", "3"],
     *     ["Vanilla Extract", "2 tsp"],
     *     ["Graham Cracker Crumbs", "300 g"],
     *     ["Butter", "100 g"]
     *   ],
     *   "method": [
     *     "Preheat oven to 325°F (163°C).",
     *     "Mix cream cheese and sugar until smooth.",
     *     "Add eggs one at a time, blending well.",
     *     "Stir in vanilla.",
     *     "Combine graham crumbs and butter. Press into a pan.",
     *     "Pour mixture over crust and bake for 45 minutes."
     *   ],
     *   "description": "A rich and creamy classic cheesecake that is perfect for all occasions.",
     *   "reviewIds": [],
     *   "backdrop": "http://example.com/images/cheesecake.jpg",
     *   "peopleReviewed": 0
     * }
     * @param recipe
     * @return
     */

    @PostMapping("/add")
    public ResponseEntity<Recipe> addRecipe (@RequestBody Recipe recipe)
    {
        System.out.println(recipe.getName());
        Recipe recipeAdded = recipeService.addRecipe(recipe);
        if(recipeAdded== null)
        {
            return ResponseEntity.badRequest().build();
        }
        return new ResponseEntity<Recipe>(recipeAdded, HttpStatus.OK);
    }

    /**
     * @apiNote
     * curl -X POST http://localhost:8080/image \
     *      -H "Content-Type: application/json" \
     *      -d '{
     *            "name": "Cheesecake",
     *            "image": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAC..."
     *           }
     * @param payload
     * @return
     */
    @PostMapping("/image")
    public ResponseEntity<String> uploadImage (@RequestBody Map<String, String> payload)
    {

        String recipeName = payload.get("name");
        String image = payload.get("image");
        try
        {
            if (image.startsWith("data:image/png;base64,")) {
                image = image.substring("data:image/png;base64,".length());
            } else if (image.startsWith("data:image/jpeg;base64,")) {
                image = image.substring("data:image/jpeg;base64,".length());
            }

            byte [] decodeBytes = Base64.getDecoder().decode(image);
            recipeService.addImage(decodeBytes, recipeName);
            return ResponseEntity.ok("File uploaded and saved to MongoDB successfully");
        }
        catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("Error uploading file: " + e.getMessage());
        }
    }

    
    public String starRating ( double star, String nameString)
    {
        double starRating = star;
        String name = nameString;

        String updating = recipeService.starRating(starRating,name);


        return updating;
    }
    public String difficultyRating (double difficult, String nameString)
    {
        double difficultyRating = difficult;
        String name = nameString;

        String updating = recipeService.starRating(difficultyRating,name);


        return updating;
    }





}
