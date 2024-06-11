//
//  MealService.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// This class represents a service atchitecture within MVVM
// When managing a lot of different microservices, this is the best (and most common) approach
// It seperates view models from having to manage service requests
class MealService {
    
    // Shared Singleton
    static let shared = MealService()
    
    // This is where a reusable custom decoder would be integrated
    // A dynamic one could also be created if all services have matching decoding strategies
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // Retrieving all meals for the specified category
    // 
    func getMeals(for category: MealCategory) async throws -> [Meal] {
        // Ensuring the meal URL is valid
        guard let url = FetchAPI.meal(category: category).url else { throw MealError.invalidUrl }
        // Custom URL session for downloading the data
        let (data, _) = try await URLSession.cuisineConfiguration.data(for: .cuisineRequest(url))
        // Decoding the data
        let decodedData = try decoder.decode(MealsResponse.self, from: data)
        return decodedData.meals
    }
    
    // Retrieving meal details for the specified meal
    func getMealDetails(for meal: Meal) async throws -> MealDetail? {
        // Ensuring the meal details URL is valid
        guard let url = FetchAPI.mealDetails(meal: meal).url else { throw MealError.invalidUrl }
        // Custom URL session for downloading the data
        let (data, _) = try await URLSession.cuisineConfiguration.data(for: .cuisineRequest(url))
        // Decoding the data
        let decodedData = try decoder.decode(MealDetailsResponse.self, from: data)
        return decodedData.meals.first
    }
}
