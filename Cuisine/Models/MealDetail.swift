//
//  MealDetail.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// Renamed the variables to make it a bit more clean
struct MealDetail: Identifiable, Decodable {
    
    let id: String
    let name: String
    
    let drinkAlternate: String?
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailUrl: URL?
    let tags: String?
    let youtubeUrl: String?
    
    let ingredientOne: String?
    let ingredientTwo: String?
    let ingredientThree: String?
    let ingredientFour: String?
    let ingredientFive: String?
    let ingredientSix: String?
    let ingredientSeven: String?
    let ingredientEight: String?
    let ingredientNine: String?
    let ingredientTen: String?
    let ingredientEleven: String?
    let ingredientTwelve: String?
    let ingredientThirteen: String?
    let ingredientFourteen: String?
    let ingredientFifteen: String?
    let ingredientSixteen: String?
    let ingredientSeventeen: String?
    let ingredientEighteen: String?
    let ingredientNineteen: String?
    let ingredientTwenty: String?
    
    let measureOne: String?
    let measureTwo: String?
    let measureThree: String?
    let measureFour: String?
    let measureFive: String?
    let measureSix: String?
    let measureSeven: String?
    let measureEight: String?
    let measureNine: String?
    let measureTen: String?
    let measureEleven: String?
    let measureTwelve: String?
    let measureThirteen: String?
    let measureFourteen: String?
    let measureFifteen: String?
    let measureSixteen: String?
    let measureSeventeen: String?
    let measureEighteen: String?
    let measureNineteen: String?
    let measureTwenty: String?
    
    let sourceUrl: String?
    let sourceImageUrl: String?
    let creativeCommonsConfirmed: String?
    let dateModifed: String?
    
    // Since these are given as individual ingredients and measurements, its best to combine them
    // Could also do this within a decoder
    // This should also be combined server side rather than having to combine on the front end
    var ingredientsMap: [String:String] {
        
        var ingredientsMap: [String:String] = [:]
        
        func addToIngredientsMap(_ ingredient: String?, _ measurement: String?) {
            if let ingredient, !ingredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, let measurement, !measurement.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                ingredientsMap[ingredient] = measurement.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        addToIngredientsMap(ingredientOne, measureOne)
        addToIngredientsMap(ingredientTwo, measureTwo)
        addToIngredientsMap(ingredientThree, measureThree)
        addToIngredientsMap(ingredientFour, measureFour)
        addToIngredientsMap(ingredientFive, measureFive)
        addToIngredientsMap(ingredientSix, measureSix)
        addToIngredientsMap(ingredientSeven, measureSeven)
        addToIngredientsMap(ingredientEight, measureEight)
        addToIngredientsMap(ingredientNine, measureNine)
        addToIngredientsMap(ingredientTen, measureTen)
        addToIngredientsMap(ingredientEleven, measureEleven)
        addToIngredientsMap(ingredientTwelve, measureTwelve)
        addToIngredientsMap(ingredientThirteen, measureThirteen)
        addToIngredientsMap(ingredientFourteen, measureFourteen)
        addToIngredientsMap(ingredientFifteen, measureFifteen)
        addToIngredientsMap(ingredientSixteen, measureSixteen)
        addToIngredientsMap(ingredientSeventeen, measureSeventeen)
        addToIngredientsMap(ingredientEighteen, measureEighteen)
        addToIngredientsMap(ingredientNineteen, measureNineteen)
        addToIngredientsMap(ingredientTwenty, measureTwenty)

        return ingredientsMap
    }
    
    var aboutMap: [String:String] {
        
        var aboutMap: [String:String] = [:]
        
        if let category, !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            aboutMap[MealDetailAbout.category.rawValue] = category
        }
        
        if let area, !area.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            aboutMap[MealDetailAbout.origin.rawValue] = area
        }
        
        if let youtubeUrl, !youtubeUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            aboutMap[MealDetailAbout.youtube.rawValue] = youtubeUrl
        }
        
        if let sourceUrl, !sourceUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            aboutMap[MealDetailAbout.website.rawValue] = sourceUrl
        }
   
        aboutMap[MealDetailAbout.id.rawValue] = id
    
        return aboutMap
    }
    
    // Manual Coding Keys should be non-existent in newer projects
    // Synchronization is critical which reduces bugs and failure points
    // ---> using keyDecodingStrategies is preferred <----
    enum CodingKeys: String, CodingKey {
        
        case id = "idMeal"
        case name = "strMeal"
        
        case drinkAlternate = "strDrinkAlternate"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailUrl = "strMealThumb"
        case tags = "strTags"
        case youtubeUrl = "strYoutube"
        
        case ingredientOne = "strIngredient1"
        case ingredientTwo = "strIngredient2"
        case ingredientThree = "strIngredient3"
        case ingredientFour = "strIngredient4"
        case ingredientFive = "strIngredient5"
        case ingredientSix = "strIngredient6"
        case ingredientSeven = "strIngredient7"
        case ingredientEight = "strIngredient8"
        case ingredientNine = "strIngredient9"
        case ingredientTen = "strIngredient10"
        case ingredientEleven = "strIngredient11"
        case ingredientTwelve = "strIngredient12"
        case ingredientThirteen = "strIngredient13"
        case ingredientFourteen = "strIngredient14"
        case ingredientFifteen = "strIngredient15"
        case ingredientSixteen = "strIngredient16"
        case ingredientSeventeen = "strIngredient17"
        case ingredientEighteen = "strIngredient18"
        case ingredientNineteen = "strIngredient19"
        case ingredientTwenty = "strIngredient20"
        
        case measureOne = "strMeasure1"
        case measureTwo = "strMeasure2"
        case measureThree = "strMeasure3"
        case measureFour = "strMeasure4"
        case measureFive = "strMeasure5"
        case measureSix = "strMeasure6"
        case measureSeven = "strMeasure7"
        case measureEight = "strMeasure8"
        case measureNine = "strMeasure9"
        case measureTen = "strMeasure10"
        case measureEleven = "strMeasure11"
        case measureTwelve = "strMeasure12"
        case measureThirteen = "strMeasure13"
        case measureFourteen = "strMeasure14"
        case measureFifteen = "strMeasure15"
        case measureSixteen = "strMeasure16"
        case measureSeventeen = "strMeasure17"
        case measureEighteen = "strMeasure18"
        case measureNineteen = "strMeasure19"
        case measureTwenty = "strMeasure20"
        
        case sourceUrl = "strSource"
        case sourceImageUrl = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed"
        case dateModifed = "dateModified"
    }
}

extension MealDetail {
 
    static var MOCK_MEAL_DETAIL: MealDetail {
        .init(id: "53005",
              name: "Strawberry Rhubarb Pie",
              drinkAlternate: nil,
              category: "Dessert",
              area: "British",
              instructions: "Pie Crust:  In a food processor, place the flour, salt, and sugar and process until combined. Add the butter and process until the mixture resembles coarse\r\n\r\nmeal (about 15 seconds). Pour 1/4 cup (60 ml) water in a slow, steady stream, through the feed tube until the dough just holds together when pinched. If necessary, add more water. Do not process more than 30 seconds.\r\nTurn the dough onto your work surface and gather into a ball. Divide the dough in half, flattening each half into a disk, cover with plastic wrap, and refrigerate for about one hour before using. This will chill the butter and relax the gluten in the flour. \r\n\r\nAfter the dough has chilled sufficiently, remove one portion of the dough from the fridge and place it on a lightly floured surface.  Roll the pastry into a 12 inch (30 cm) circle. (To prevent the pastry from sticking to the counter and to ensure uniform thickness, keep lifting up and turning the pastry a quarter turn as you roll (always roll from the center of the pastry outwards).)  Fold the dough in half and gently transfer to a 9 inch (23 cm) pie pan. Brush off any excess flour and trim any overhanging pastry to an edge of 1/2 inch (1.5 cm). Refrigerate the pastry, covered with plastic wrap, while you make the filling. \r\n\r\nRemove the second round of pastry and roll it into a 13 inch (30 cm) circle. Using a pastry wheel or pizza cutter, cut the pastry into about 3/4 inch (2 cm) strips. Place the strips of pastry on a parchment paper-lined baking sheet, cover with plastic wrap, and place in the refrigerator for about 10 minutes. \r\n\r\nMake the Strawberry Rhubarb Filling: Place the cut strawberries and rhubarb in a large bowl. In a small bowl mix together the cornstarch, sugar, and ground cinnamon. \r\n\r\nRemove the chilled pie crust from the fridge. Sprinkle about 2 tablespoons of the sugar mixture over the bottom of the pastry crust. Add the remaining sugar mixture to the strawberries and rhubarb and gently toss to combine. Pour the fruit mixture into the prepared pie shell. Sprinkle the fruit with about 1 teaspoon of lemon juice and dot with 2 tablespoons of butter.\r\n\r\nRemove the lattice pastry from the refrigerator and, starting at the center with the longest strips and working outwards, place half the strips, spacing about 1 inch (2.5 cm) apart, on top of the filling. (Use the shortest pastry strips at the outer edges.) Then, gently fold back, about halfway, every other strip of pastry. Take another strip of pastry and place it perpendicular on top of the first strips of pastry. Unfold the bottom strips of pastry and then fold back the strips that weren't folded back the first time. Lay another strip of pastry perpendicular on top of the filling and then continue with the remaining strips. Trim the edges of the pastry strips, leaving a 1 inch (2.5 cm) overhang. Seal the edges of the pastry strips by folding them under the bottom pastry crust and flute the edges of the pastry. Brush the lattice pastry with milk and sprinkle with a little sugar. Cover and place in the refrigerator while you preheat the oven to 400 degrees F (205 degrees C) and place the oven rack in the lower third of the oven. Put a baking sheet, lined with aluminum foil, on the oven rack (to catch any spills.)\r\n\r\nPlace the pie plate on the hot baking sheet and bake the pie for about 35 minutes and then, if the edges of the pie are browning too much, cover with a foil ring. Continue to bake the pie for about another 10 minutes or until the crust is a golden brown color and the fruit juices begin to bubble.\r\n\r\nRemove the pie from the oven and place on a wire rack to cool for several hours. Serve at room temperature with softly whipped cream or vanilla ice cream. Leftovers can be stored in the refrigerator for about 3 days. Reheat before serving. This pie can be frozen.\r\n\r\nMakes one 9 inch (23 cm) pie.",
              thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg"),
              tags: "Pudding,Pie,Baking,Fruity,Glazed",
              youtubeUrl: "https://www.youtube.com/watch?v=tGw5Pwm4YA0",
              ingredientOne: "Flour",
              ingredientTwo: "Salt",
              ingredientThree: "Sugar",
              ingredientFour: "Butter",
              ingredientFive: "Water",
              ingredientSix: "Rhubarb",
              ingredientSeven: "Strawberries",
              ingredientEight: "Cornstarch",
              ingredientNine: "Sugar",
              ingredientTen: "Cinnamon",
              ingredientEleven: "Lemon Juice",
              ingredientTwelve: "Unsalted Butter",
              ingredientThirteen: "Milk",
              ingredientFourteen: "Sugar",
              ingredientFifteen: "",
              ingredientSixteen: "",
              ingredientSeventeen: "",
              ingredientEighteen: "",
              ingredientNineteen: "",
              ingredientTwenty: "",
              measureOne: "350g",
              measureTwo: "1 tsp ",
              measureThree: "2 tbs",
              measureFour: "1 cup ",
              measureFive: "1/2 cup ",
              measureSix: "450g",
              measureSeven: "450g",
              measureEight: "3 tbs",
              measureNine: "150g",
              measureTen: "1/4 tsp",
              measureEleven: "1 tsp ",
              measureTwelve: "2 tbs",
              measureThirteen: "2 tbs",
              measureFourteen: "Spinkling",
              measureFifteen: "",
              measureSixteen: "",
              measureSeventeen: "",
              measureEighteen: "",
              measureNineteen: "",
              measureTwenty: "",
              sourceUrl: "https://www.joyofbaking.com/StrawberryRhubarbPie.html",
              sourceImageUrl: nil,
              creativeCommonsConfirmed: nil,
              dateModifed: nil)
    }
}
