//
//  RecipeDetailsTagsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsTagsView: View {
    
    let tags: String
    
    var body: some View {
        HStack {
            ForEach(tags.split(separator: ","), id: \.self) { tag in
                Text(tag)
                    .roundedRectBackground()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeDetailsTagsView(tags: MealDetail.MOCK_MEAL_DETAIL.tags ?? "No Mock Data")
}
