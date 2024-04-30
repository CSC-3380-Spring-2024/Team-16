package com.example.foodApp.Recipe;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.MediaType;



import java.util.Base64;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/recipe")
@CrossOrigin(origins = "*")
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
    @GetMapping("/images/{id}")
    public ResponseEntity<byte[]> getImage(@PathVariable String id) {
        byte[] imageData = recipeService.getImage(new ObjectId(id));
        return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_PNG) // or MediaType.IMAGE_PNG, depending on the image format
                .body(imageData);
    }

   //PostMapping

    /**
     * @apiNote
     *http://localhost:8080/api/recipe/add
     * {
     *     "recipe": {
     *   "name": "Classic Cheesecake", // with the name of recipe the api will return null and not will be added
     *   "starRating": 4.8,
     *   "difficultyRating": 3.5,
     *   "servingSize": 12,
     *   "ingredients": [               // without ingredient the api will return null and not will be added
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
     *   "backdrop": "http://example.com/images/cheesecake.jpg",
     *   "peopleReviewed": 0
     *   "difficultyRating": 0
     *   "starRating": 0
     *
     * },
     *     "username": "Jonh Doe"
     * }
     * @param
     * @return
     */

    @PostMapping("/add")
    public ResponseEntity<Recipe> addRecipe (@RequestBody RecipeAndUsernameRequest recipeAndUsernameRequest)
    {
        Recipe recipe = recipeAndUsernameRequest.getRecipe();
        String username = recipeAndUsernameRequest.getUsername();
        System.out.println(recipe.getName());
        Recipe recipeAdded = recipeService.addRecipe(recipe,username);
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
     *            "id": "66259dd4cf6c9bdb66b36f6a",
     *            "image": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAC..."  // image need to be converted to base64
     *           }
     * @param payload
     * @return
     */
    @PostMapping("/image")
    public ResponseEntity<String> uploadImage (@RequestBody Map<String, String> payload)
    {

        String id = payload.get("id");
        String image = payload.get("image");
        try
        {
            // Check for PNG format
            if (image.startsWith("data:image/png;base64,")) {
                image = image.substring("data:image/png;base64,".length());
            }
            // Check for JPEG format
            else if (image.startsWith("data:image/jpeg;base64,")) {
                image = image.substring("data:image/jpeg;base64,".length());
            } else {
                // Handle unsupported format
                return ResponseEntity.badRequest().body("Unsupported image format");
            }

            byte [] decodeBytes = Base64.getDecoder().decode(image);
            recipeService.addImage(decodeBytes, id);
            return ResponseEntity.ok("File uploaded and saved to MongoDB successfully");
        }
        catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("Error uploading file: " + e.getMessage());
        }
    }





}
