//
//  CuisineTests.swift
//  CuisineTests
//
//  Created by Nolan Fuchs on 6/4/24.
//

import XCTest
@testable import Cuisine

final class CuisineTests: XCTestCase {
    
    @MainActor
    let viewModel = MainViewModel()
     
    /// Ensures view model is set with the correct starting properties
    /// Filter should be alphabetical
    /// Category should be dessert
    @MainActor
    func test_Dessert_Initialization() {
        XCTAssertEqual(viewModel.mealFilter, .alphabetical)
        XCTAssertEqual(viewModel.selectedCategory, .dessert)
    }

    /// Testing all filter options for meals
    @MainActor
    func test_Meal_Filter() async throws {
        
        viewModel.mealsSearchResults = Meal.MOCK_MEALS
        
        for filter in MealFilter.allCases {
            var sortedMeals = Meal.MOCK_MEALS
            viewModel.mealFilter = filter
            
            switch filter {
            case .alphabetical:
                sortedMeals = Meal.MOCK_MEALS.sorted(by: { $0.name < $1.name })
            case .id:
                sortedMeals = Meal.MOCK_MEALS.sorted(by: { $0.id < $1.id })
            }
            
            viewModel.filterMeals()
            XCTAssertEqual(sortedMeals, viewModel.mealsSearchResults)
        }
    }

    func test_Performance_Example() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
