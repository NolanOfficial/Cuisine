//
//  RecipeView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

/// This view will load the image from cache
/// If none is available, it will load from the given url
struct RecipeView: View {
    
    let meal: Meal
    
    var body: some View {
        HStack(spacing: 10) {
            RemoteImage(url: meal.thumbnailUrl)
                .scaledToFill()
                .frame(width: 120, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .environment(\.colorScheme, .dark)
        
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.subheadline.weight(.semibold))
                Text("Id: \(meal.id)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    RecipeView(meal: .MOCK_MEAL)
}
