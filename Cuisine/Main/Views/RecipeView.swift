//
//  RecipeView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeView: View {
    
    let meal: Meal
    
    var body: some View {
        HStack(spacing: 10) {
            
            // Image of the recipe
            RemoteImage(url: meal.thumbnailUrl)
                .scaledToFill()
                .frame(width: 120, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .environment(\.colorScheme, .dark)
            
            // Meal Name and ID
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.subheadline.weight(.semibold))
                Text("ID: \(meal.id)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RecipeView(meal: .MOCK_MEAL)
}
