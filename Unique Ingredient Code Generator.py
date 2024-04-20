import json

def extract_unique_ingredients(json_file_path):
    # Set to hold all unique ingredients
    unique_ingredients = set()

    # Open the JSON file and load data
    with open(json_file_path, 'r') as file:
        data = json.load(file)

        # Iterate over each recipe in the data
        for recipe in data:
            # Iterate over each ingredient in the recipe
            for ingredient in recipe['ingredients']:
                # Add the ingredient name to the set (index 0 of the sublist)
                unique_ingredients.add(ingredient[0])

    return unique_ingredients

# Example usage
json_file_path = r'C:\Users\chunh\Downloads\recipes.json'  # Path to your JSON file
unique_ingredients = extract_unique_ingredients(json_file_path)

# Define the file path for saving the output
output_file_path = 'unique_ingredients.txt'

# Write the unique ingredients to the output file
with open(output_file_path, 'w') as output_file:
    for ingredient in sorted(unique_ingredients):  # Sorting for easier readability
        output_file.write(ingredient + '\n')

print("Unique Ingredients saved to:", output_file_path)