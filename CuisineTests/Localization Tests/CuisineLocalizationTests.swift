//
//  CuisineLocalizationTests.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/12/24.
//

import XCTest
@testable import Cuisine

final class CuisineLocalizationTests: XCTestCase {
    
    let localizedLanguages = Bundle.main.localizations
    
    // Localized words to test against
    let recipe = "Recipe"
    let dessert = "Dessert"
    let instructions = "Instructions"
    
    /// Tests that the correct localized languages are available
    func test_Localized_Languages_Exist() {
        XCTAssertTrue(localizedLanguages.contains("en"))
        XCTAssertTrue(localizedLanguages.contains("sv"))
    }
    
    /// Tests base words for english localization
    func test_English_Localization() {
        
        let languageCode = "en"
        
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            XCTFail("Could not load the localization bundle")
            return
        }
        guard let testBundle = Bundle(path: bundlePath) else {
            XCTFail("Could not load the English localization bundle")
            return
        }
        
        verifyLocalization(key: recipe, expected: "Recipe", bundle: testBundle)
        verifyLocalization(key: dessert, expected: "Dessert", bundle: testBundle)
        verifyLocalization(key: instructions, expected: "Instructions", bundle: testBundle)
    }
    
    /// Tests base words for swedish localization
    func test_Swedish_Localization() {
        
        let languageCode = "sv"
        
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            XCTFail("Could not load the localization bundle")
            return
        }
        guard let testBundle = Bundle(path: bundlePath) else {
            XCTFail("Could not load the Swedish localization bundle")
            return
        }
        
        verifyLocalization(key: recipe, expected: "Recept", bundle: testBundle)
        verifyLocalization(key: dessert, expected: "Öken", bundle: testBundle)
        verifyLocalization(key: instructions, expected: "Instruktioner", bundle: testBundle)
    }

    /// Compares key to expeted value within the localization bundle
    private func verifyLocalization(key: String, expected: String, bundle: Bundle) {
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        XCTAssertEqual(localizedString, expected, "Localization for key '\(key)' did not match. Expected: '\(expected)', got: '\(localizedString)'")
    }
}
