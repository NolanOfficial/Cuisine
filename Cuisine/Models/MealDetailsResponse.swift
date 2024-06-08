//
//  MealDetailsResponse.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// The response for meals
// This would usually be accompanied with a status message and optional status codes
struct MealDetailsResponse: Decodable {
    var meals: [MealDetail]
}
