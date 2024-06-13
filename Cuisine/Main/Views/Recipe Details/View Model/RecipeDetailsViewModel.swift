//
//  RecipeDetailsViewModel.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/12/24.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    
    // MARK: Services
    
    private let mealService = MealService()
    
    // MARK: Published values
    
    @Published var state: LoadingState = .loading

    @Published var mealDetail: MealDetail?
    
    @Published var mealError: MealError?
    
    @Published var showMealError = false
    
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
            mealError = error
            showMealError = true
            state = .error
        } catch {
            mealError = MealError.unknown
            showMealError = true
            state = .error
        }
    }
}
