//
//  MealDetailAbout.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/8/24.
//

import Foundation

enum MealDetailAbout: String {
    
    case id
    case category
    case origin
    case youtube
    case website
    
    var imageName: String {
        switch self {
        case .id:
            return "number.circle.fill"
        case .category:
            return "list.bullet.rectangle"
        case .origin:
            return "map"
        case .youtube:
            return "video"
        case .website:
            return "safari"
        }
    }
}
