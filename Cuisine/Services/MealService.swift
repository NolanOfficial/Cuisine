//
//  MealService.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

/// Meal Service Protocol
protocol MealServiceProtocol {
    func getMeals(for category: MealCategory) async throws -> [Meal]
    func getMealDetails(for meal: Meal) async throws -> MealDetail?
}

/// This class represents a service atchitecture within MVVM
///
/// When managing a lot of different microservices, this is the best (and most common) approach
/// as it seperates view models from having to manage service requests
class MealService: MealServiceProtocol {
    
    /// Shared Singleton
    static let shared = MealService()
    
    let network = Network()

    /// A reusable meal service JSON decoder
    ///
    /// A dynamic decoder could also be created if all services have matching decoding strategies
    ///
    /// - Important: .convertFromSnakeCase is disabled since it's not actually used.
    /// This is to indicate how it would work if the json matched the model.
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// Downloads all meals for the specified category
    ///
    /// - Parameter category: The meal category in which to get the meals from
    ///
    /// - Returns: an array of all retrieved meals
    func getMeals(for category: MealCategory) async throws -> [Meal] {
        // Ensuring the meal URL is valid
        guard let url = FetchAPI.meal(category: category).url else { throw MealError.invalidUrl }
        // Decoding the data
        let response: MealsResponse = try await network.fetch(url)
        // Return decoded meals
        return response.meals
    }
    
    /// Downloads all meal details for the specified meal
    ///
    /// - Parameter category: The meal in which to get the details from
    ///
    /// - Returns: An optional that contains the meal details
    func getMealDetails(for meal: Meal) async throws -> MealDetail? {
        // Ensuring the meal details URL is valid
        guard let url = FetchAPI.mealDetails(meal: meal).url else { throw MealError.invalidUrl }
        // Decoding the data
        let response: MealDetailsResponse = try await network.fetch(url)
        return response.meals.first
    }
}
