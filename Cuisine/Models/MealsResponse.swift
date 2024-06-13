//
//  MealsResponse.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// This would usually be accompanied with a status message and optional status codes
struct MealsResponse: Decodable {
    let meals: [Meal]
}
