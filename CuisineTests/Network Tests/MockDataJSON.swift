//
//  MockDataJSON.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

struct MockDataJSON {
    
    static var mockMealsSuccessData =
    """
    {
        "meals": [
            {
                "strMeal": "Battenberg Cake",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                "idMeal": "52894"
            }
        ]
    }
    """
    
    static var mockMealsFailedData =
    """
    {
        "meals": [
            {
                "strMeal": "Battenberg Cake",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
            }
        ]
    }
    """
    
    static var mockMealDetailsData =
    """
    {
        "meals": [
            {
                "idMeal": "52894",
                "strMeal": "Battenberg Cake",
                "strDrinkAlternate": null,
                "strCategory": "Dessert",
                "strArea": "British",
                "strMealThumb": "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg",
                "strTags": "Cake,Sweet",
                "strYoutube": "https://www.youtube.com/watch?v=aB41Q7kDZQ0",
                "strIngredient1": "Butter",
                "strIngredient2": "Caster Sugar",
                "strIngredient3": "Self-raising Flour",
                "strIngredient4": "Almonds",
                "strIngredient5": "Baking Powder",
                "strIngredient6": "Eggs",
                "strIngredient7": "Vanilla Extract",
                "strIngredient8": "Almond Extract",
                "strIngredient9": "Butter",
                "strIngredient10": "Caster Sugar",
                "strIngredient11": "Self-raising Flour",
                "strIngredient12": "Almonds",
                "strIngredient13": "Baking Powder",
                "strIngredient14": "Eggs",
                "strIngredient15": "Vanilla Extract",
                "strIngredient16": "Almond Extract",
                "strIngredient17": "Pink Food Colouring",
                "strIngredient18": "Apricot",
                "strIngredient19": "Marzipan",
                "strIngredient20": "Icing Sugar",
                "strMeasure1": "175g",
                "strMeasure2": "175g",
                "strMeasure3": "140g",
                "strMeasure4": "50g",
                "strMeasure5": "½ tsp",
                "strMeasure6": "3 Medium",
                "strMeasure7": "½ tsp",
                "strMeasure8": "¼ teaspoon",
                "strMeasure9": "175g",
                "strMeasure10": "175g",
                "strMeasure11": "140g",
                "strMeasure12": "50g",
                "strMeasure13": "½ tsp",
                "strMeasure14": "3 Medium",
                "strMeasure15": "½ tsp",
                "strMeasure16": "¼ teaspoon",
                "strMeasure17": "½ tsp",
                "strMeasure18": "200g",
                "strMeasure19": "1kg",
                "strMeasure20": "Dusting",
                "strSource": "https://www.bbcgoodfood.com/recipes/1120657/battenberg-cake",
                "strImageSource": null,
                "strCreativeCommonsConfirmed": null,
                "dateModified": null
            }
        ]
    }
    """
}
