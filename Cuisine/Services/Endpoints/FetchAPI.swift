//
//  FetchAPI.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

/// This enum creates different endpoints for the Fetch API in which we can download from
enum FetchAPI {
    
    /// Meal endpoint for a specific category
    case meal(category: MealCategory)
    /// Meal details endpoint for a specific meal
    case mealDetails(meal: Meal)
    
    /// The Fetch URL path subcomponent
    private var path: String {
        switch self {
        case .meal:
            return "/api/json/v1/1/filter.php"
        case .mealDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    /// An array of query items for the Fetch URL in the order in which they appear in the original query string
    private var queryItems: [URLQueryItem] {
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
    
    /// A Fetch URL created from the components.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "themealdb.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
