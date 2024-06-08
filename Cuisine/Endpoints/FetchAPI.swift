//
//  FetchAPI.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

enum FetchAPI {
    
    case meal(category: MealCategory)
    case mealDetails(meal: Meal)
    
    var path: String {
        switch self {
        case .meal:
            return "/api/json/v1/1/filter.php"
        case .mealDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .meal(let category):
            return [
                URLQueryItem(name: "c", value: category.rawValue.capitalized)
            ]
        case .mealDetails(let meal):
            return [
                URLQueryItem(name: "i", value: meal.id)
            ]
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
}
