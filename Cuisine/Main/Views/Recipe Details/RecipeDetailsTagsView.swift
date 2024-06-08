//
//  RecipeDetailsTagsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsTagsView: View {
    
    let mealDetail: MealDetail
    
    var body: some View {
        if let tags = mealDetail.tags {
            VStack {
                HStack {
                    Text("Tags")
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    ForEach(tags.split(separator: ","), id: \.self) { tag in
                        Text(tag)
                            .font(.subheadline)
                            .roundedRectBackground()
                    }
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    RecipeDetailsTagsView(mealDetail: .MOCK_MEAL_DETAIL)
}
