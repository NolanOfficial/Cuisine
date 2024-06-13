//
//  RecipeDetailsHeaderView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsHeaderView: View {
    
    let meal: Meal
    
    var body: some View {
        Text(meal.name)
                .font(.system(size: 28, weight: .medium))
        HStack {
            Spacer()
            RemoteImage(url: meal.thumbnailUrl)
                .scaledToFit()
                .frame(height: 240)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Spacer()
        }
    }
}

#Preview {
    RecipeDetailsHeaderView(meal: .MOCK_MEAL)
}
