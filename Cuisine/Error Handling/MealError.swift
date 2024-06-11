//
//  MealError.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

/// Custom error for the Fetch API
enum MealError: Error {
    
    /// Invalid Url
    case invalidUrl
    /// Unknown error
    case unknown
    
    /// The title of the error
    var title: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .unknown:
            return "Unknown Error"
        }
    }
    
    /// A description of the error
    var message: String {
        switch self {
        case .invalidUrl:
            return "The url was invalid. Please try again later."
        case .unknown:
            return "Something went wrong. Please try again later."
        }
    }
}
