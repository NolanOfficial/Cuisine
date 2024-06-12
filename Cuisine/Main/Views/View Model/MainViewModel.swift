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
///
/// - Attention: This class is run entirely on the main thread due to setting
/// multiple variables through an async method.
@MainActor
class MainViewModel: ObservableObject {
    
    // MARK: Services
    
    /// Meal API service
    private let mealService = MealService()
    
    // MARK: Published values
    
    /// The meals retrieved to display from the selected category
    @Published var meals: [Meal] = []
    
    /// The meals retrieved to display from the selected category
    @Published var mealsSearchResults: [Meal] = []
    
    /// The category of meals to display
    @Published var selectedCategory: MealCategory = .dessert
    
    /// The filter state of the meals
    @Published var mealFilter: MealFilter = .alphabetical
    
    /// Boolean indicating the state of the view
    @Published var state: LoadingState = .loading
    
    /// Meal error if thrown
    @Published var error: MealError? = nil
    
    /// Boolean indicating wether to show the meal error
    @Published var showError = false
    
    // MARK: Functions
    
    /// Asynchronously downloads meals from the meal service API
    func getMeals() async {
        do {
            // Setting the view state to loading
            state = .loading
            
            // Asynchronously set meals
            meals = try await mealService.getMeals(for: selectedCategory)
            mealsSearchResults = meals
            
            // Filter the meals
            filterMeals()
            
            // Update the view state
            state = meals.isEmpty ? .empty : .result
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
    
    /// Filters meals based on filter selection
    func filterMeals() {
        switch mealFilter {
        case .alphabetical:
            meals.sort(by: { $0.name < $1.name })
        case .id:
            meals.sort(by: { $0.id < $1.id })
        }
    }
    
    /// Function is called as the user types to search for a meal
    ///
    /// - Parameter searchText: String of what the user has currently typed
    func searchMeals(with searchText: String) {
        if searchText.isEmpty {
            mealsSearchResults = meals
        } else {
            let filteredResults = meals.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.id.contains(searchText) }
            mealsSearchResults = filteredResults
        }
    }
}
