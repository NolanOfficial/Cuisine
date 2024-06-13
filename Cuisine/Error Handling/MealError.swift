//
//  MealError.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

/// Custom errors for the Fetch API
enum MealError: Error {
    
    case invalidUrl
    case unknown
    
    var title: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        }
    }
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "The url was invalid. Please try again later."
        case .unknown:
            return "Something went wrong. Please try again later."
        }
    }
}
