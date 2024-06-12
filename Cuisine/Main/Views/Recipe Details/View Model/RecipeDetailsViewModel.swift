//
//  RecipeDetailsViewModel.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/12/24.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
    // MARK: Services
    
    /// Meal API service
    private let mealService = MealService()
    
    // MARK: Published values
    
    /// Boolean indicating the state of the view
    @Published var state: LoadingState = .loading

    /// The details of a meal
    @Published var mealDetail: MealDetail?
    
    /// Meal error if thrown
    @Published var error: MealError?
    
    /// Boolean indicating wether to show the meal error
    @Published var showError = false
    
    // MARK: Functions
    
    /// Asynchronously downloads meal details from the meal service API
    ///
    /// - Parameter meal: The meal in which to get the deatils for
    ///
    /// - returns: The meal details downloaded
    @MainActor
    func getMealDetail(for meal: Meal) async {
        do {
            state = .loading
            mealDetail = try await mealService.getMealDetails(for: meal)
            state = .result
        } catch let error as MealError {
            // Setting custom error
            self.error = error
            showError = true
            // Set error view state
            state = .error
        } catch {
            // Setting generic error
            self.error = MealError.unknown
            showError = true
            // Set error view state
            state = .error
        }
    }
}
