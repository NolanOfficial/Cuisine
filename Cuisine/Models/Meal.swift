//
//  Meal.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// Important to note: Depending on the backend, these could also be optional
struct Meal: Identifiable, Decodable, Hashable {
    
    let id: String
    let name: String
    let thumbnailUrl: URL?
    
    // Manual Coding Keys should be non-existent in newer project
    // synchronization is critical which reduces bugs and failure points
    // ---> using keyDecodingStrategies is preferred <----
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailUrl = "strMealThumb"
    }
}

extension Meal {
    
    static var MOCK_MEAL: Meal {
        .init(id: "53005", name: "Strawberry Rhubarb Pie", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg"))
    }
    
    static var MOCK_DESSERT_MEAL: Meal {
        .init(id: "53005", name: "Strawberry Rhubarb Pie", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg"))
    }
    
    static var MOCK_MEALS: [Meal] {
        [
            .init(id: "53005", name: "Strawberry Rhubarb Pie", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/178z5o1585514569.jpg")),
            .init(id: "52890", name: "Jam Roly-Poly", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/ysqupp1511640538.jpg")),
            .init(id: "52787", name: "Hot Chocolate Fudge", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/xrysxr1483568462.jpg")),
            .init(id: "52893", name: "Apple & Blackberry Crumble", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg")),
            .init(id: "52988", name: "Classic Christmas pudding", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/1d85821576790598.jpg")),
            .init(id: "53022", name: "Polskie Naleśniki (Polish Pancakes)", thumbnailUrl: URL(string: "https://www.themealdb.com/images/media/meals/58bkyo1593350017.jpg"))
        ]
    }
    
}
