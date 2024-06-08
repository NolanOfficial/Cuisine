//
//  MealCategory.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import Foundation

// These could be retrieved through an endpoint but:
// 1. The images weren't going to be used so an extra request was unnecessary
// 2. Performace would've been impacted for something minimal

// Real world, an endpoint would be used, but the data would also contain correct and more relevant information
enum MealCategory: String, CaseIterable {
    
    case beef
    case breakfast
    case chicken
    case dessert
    case goat
    case lamb
    case miscellaneous
    case pasta
    case pork
    case seafood
    case side
    case starter
    case vegan
    case vegetarian
}
