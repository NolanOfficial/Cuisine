//
//  CuisineUITests.swift
//  CuisineUITests
//
//  Created by Nolan Fuchs on 6/4/24.
//

import XCTest
@testable import Cuisine

final class CuisineUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Tests that a dessert item exists
    // This wouldn't count on real data normally and launch arguments would be set
    func testDesertRecipeExists() throws {
        let app = XCUIApplication()
        app.launch()

        // Retrieving card we want to find
        let dessertCard = app.buttons["\(Meal.MOCK_DESSERT_MEAL.name) Recipe"]
        
        // Setting scroll count properties for a non infinite scroll
        let maxSwipes = 12
        var currentSwipe = 0
        
        // Within our scroll count, find the desert card
        while !dessertCard.exists && currentSwipe < maxSwipes  {
            app.swipeUp()
            currentSwipe += 1
        }
        
        // See if the card exsits
        XCTAssertTrue(dessertCard.exists)
    }
    
    // Tests that the dessert category exists
    func testDessertCategoryExists() throws {
        let app = XCUIApplication()
        app.launch()

        // Retrieving dessert category
        let dessertCategory = app.buttons["\(MealCategory.dessert.rawValue.capitalized) Meal Category"]
        
        // See if the category exsits
        XCTAssertTrue(dessertCategory.exists)
    }
    
    // Test ensures that the menu filter exists
    // Also ensures that the alphabetical filter exists
    func testAlphabeticalFilterExists() throws {
        let app = XCUIApplication()
        app.launch()

        // Retrieving filter button
        let filterMenu = app.buttons["Recipe Filter Menu"]
        
        // See if the filter button exsits
        XCTAssertTrue(filterMenu.exists)
        
        filterMenu.tapUnhittable()
        
        // Get alphabetical filter
        let alphabeticalFilterButton = app.buttons["\(MealFilter.alphabetical.rawValue.capitalized) Recipe Filter"]
        
        // See if the alphabetical filter button exsits
        XCTAssertTrue(alphabeticalFilterButton.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

// Need this since there's a hittable bug
// Buttons that are enabled and exist cause an error on tap
// Offset the tap to fix it
extension XCUIElement {
    func tapUnhittable() {
        XCTContext.runActivity(named: "Tap \(self) by coordinate") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }
}
