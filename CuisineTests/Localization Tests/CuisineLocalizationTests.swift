//
//  CuisineLocalizationTests.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/12/24.
//

import XCTest
@testable import Cuisine
import SwiftUICore

final class CuisineLocalizationTests: XCTestCase {
    
    /// All available localized languages
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
        
        // Set the locale to Swedish
        let languageCode = "en"
        let currentLocale = NSLocale.current
        guard let languageIdentifier = Locale(identifier: languageCode).identifier as String? else {
            XCTFail("Could not set locale to Swedish")
            return
        }
        
        // Load the Swedish localization bundle
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            XCTFail("Could not load the localization bundle")
            return
        }
        // Create the bundle path
        guard let testBundle = Bundle(path: bundlePath) else {
            XCTFail("Could not load the Swedish localization bundle")
            return
        }
        
        // Test specific localized strings
        verifyLocalization(key: recipe, expected: "Recipe", bundle: testBundle)
        verifyLocalization(key: dessert, expected: "Dessert", bundle: testBundle)
        verifyLocalization(key: instructions, expected: "Instructions", bundle: testBundle)
    }
    
    /// Tests base words for swedish localization
    func test_Swedish_Localization() {
        
        // Set the locale to Swedish
        let languageCode = "sv"
        let currentLocale = NSLocale.current
        guard let languageIdentifier = Locale(identifier: languageCode).identifier as String? else {
            XCTFail("Could not set locale to Swedish")
            return
        }
        
        // Load the Swedish localization bundle
        guard let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            XCTFail("Could not load the localization bundle")
            return
        }
        // Create the bundle path
        guard let testBundle = Bundle(path: bundlePath) else {
            XCTFail("Could not load the Swedish localization bundle")
            return
        }
        
        // Test specific localized strings
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