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
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
     
    // Ensures view model is set with the correct starting properties
    // Filter should be alphabetical
    // Category should be dessert
    @MainActor
    func testDessertInit() {
        XCTAssertEqual(viewModel.mealFilter, .alphabetical)
        XCTAssertEqual(viewModel.selectedCategory, .dessert)
    }

    // Testing all filter options for meals
    @MainActor
    func testMealFilter() async throws {
        
        viewModel.meals = Meal.MOCK_MEALS
        
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
            XCTAssertEqual(sortedMeals, viewModel.meals)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
