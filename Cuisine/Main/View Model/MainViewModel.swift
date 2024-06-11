//
//  MainViewModel.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

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
    private let mealService = MealService.shared
    
    // MARK: Published values
    
    /// The meals retrieved to display from the selected category
    @Published var meals: [Meal] = []
    
    /// The category of meals to display
    @Published var selectedCategory: MealCategory = .dessert
    
    /// The filter state of the meals
    @Published var mealFilter: MealFilter = .alphabetical
    
    /// Boolean indicating if the view is loading for the first time
    @Published var isInitializing = true
    
    /// Boolean indicating if the current meal selection is downloading
    @Published var isDownloadingMeals = false
    
    /// Meal error if thrown
    @Published var mealError: MealError? = nil
    
    /// Boolean indicating wether to show the meal error
    @Published var showMealError = false
    
    // MARK: Functions
    
    /// Asynchronously downloads meals from the meal service API
    func getMeals() async {
        do {
            isDownloadingMeals = true
            meals = try await mealService.getMeals(for: selectedCategory)
            filterMeals()
            isDownloadingMeals = false
        } catch let error as MealError {
            // Retrieving custom error handles
            mealError = error
            showMealError = true
        } catch {
            // Setting generic error
            mealError = MealError.unknown
            showMealError = true
        }
    }
    
    /// Asynchronously downloads meal details from the meal service API
    ///
    /// - Parameter meal: The meal in which to get the deatils for
    ///
    /// - returns: The meal details downloaded
    func getMealDetail(for meal: Meal) async -> MealDetail? {
        do {
            return try await mealService.getMealDetails(for: meal)
        } catch let error as MealError {
            // Retrieving custom error handles
            mealError = error
            showMealError = true
        } catch {
            // Setting generic error
            mealError = MealError.unknown
            showMealError = true
        }
        return nil
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
}
