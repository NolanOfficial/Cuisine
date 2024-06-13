//
//  MainViewModel.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

/// View Model that represents the Main View
///
/// Contains all objects used for downloading and setting meals and meal details
class MainViewModel: ObservableObject {
    
    // MARK: Services
    
    private let mealService = MealService()
    
    // MARK: Published values
    
    @Published var meals: [Meal] = []
    
    @Published var mealsSearchResults: [Meal] = []
    
    @Published var selectedCategory: MealCategory = .dessert
    
    @Published var mealFilter: MealFilter = .alphabetical
    
    @Published var state: LoadingState = .loading
    
    @Published var error: MealError? = nil
    
    @Published var showError = false
    
    // MARK: Functions
    
    /// Asynchronously downloads meals from the meal service API
    @MainActor
    func getMeals() async {
        do {
            state = .loading
            meals = try await mealService.getMeals(for: selectedCategory)
            mealsSearchResults = meals
            filterMeals()
            state = meals.isEmpty ? .empty : .result
            
        } catch let error as MealError {
            self.error = error
            showError = true
            state = .error
            
        } catch {
            self.error = MealError.unknown
            showError = true
            state = .error
        }
    }
    
    /// Filters meals based on filter selection
    @MainActor
    func filterMeals() {
        switch mealFilter {
        case .alphabetical:
            mealsSearchResults.sort(by: { $0.name < $1.name })
        case .id:
            mealsSearchResults.sort(by: { $0.id < $1.id })
        }
    }
    
    /// Function is called as the user types to search for a meal
    ///
    /// User can search based on either name or id
    ///
    /// - Parameter searchText: String of what the user has currently typed
    @MainActor
    func searchMeals(with searchText: String) {
        if searchText.isEmpty {
            mealsSearchResults = meals
        } else {
            mealsSearchResults = meals.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.id.contains(searchText) }
        }
    }
}
