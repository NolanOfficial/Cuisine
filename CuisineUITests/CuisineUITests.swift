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
        continueAfterFailure = false
    }

    /// Tests that a dessert recipe exists
    func test_Desert_Recipe_Exists() throws {
        let app = XCUIApplication()
        app.launch()

        let dessertCard = app.buttons["\(Meal.MOCK_DESSERT_MEAL.name) Recipe"]
        
        let maxSwipes = 12
        var currentSwipe = 0
        
        while !dessertCard.exists && currentSwipe < maxSwipes  {
            app.swipeUp()
            currentSwipe += 1
        }
        
        XCTAssertTrue(dessertCard.exists)
    }
    
    /// Tests that the dessert category exists
    func test_Dessert_Category_Exists() throws {
        let app = XCUIApplication()
        app.launch()

        let dessertCategory = app.buttons["\(MealCategory.dessert.rawValue.capitalized) Meal Category"]

        XCTAssertTrue(dessertCategory.exists)
    }
    
    /// Test ensures that the menu filter exists
    /// Also ensures that the alphabetical filter exists
    func test_Alphabetical_Filter_Exists() throws {
        let app = XCUIApplication()
        app.launch()

        let filterMenu = app.buttons["Recipe Filter Menu"]
        
        XCTAssertTrue(filterMenu.exists)
        
        filterMenu.tapUnhittable()
        
        let alphabeticalFilterButton = app.buttons["\(MealFilter.alphabetical.rawValue.capitalized) Recipe Filter"]
        
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

// Need this since there's a hittable UITest bug
// Buttons that are enabled and exist cause an error on tap
// Offset the tap to fix it
extension XCUIElement {
    func tapUnhittable() {
        XCTContext.runActivity(named: "Tap \(self) by coordinate") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }
}
