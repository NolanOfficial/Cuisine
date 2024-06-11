//
//  RecipeDetailsIngredientsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsIngredientsView: View {
    
    let mealDetail: MealDetail
    
    var body: some View {
        
        /// Apple's Collections Package `OrderedDictionary` is much more preferable here
        ForEach(Array(mealDetail.ingredientsMap.keys), id: \.self) { ingredient in
            HStack {
                Image(systemName: "fork.knife.circle")
                    .imageScale(.large)
                
                Text(ingredient)
                    .font(.subheadline)
                
                Spacer()
                
                Text(mealDetail.ingredientsMap[ingredient] ?? "Unkown")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            .padding(6)
        }
    }
}

#Preview {
    RecipeDetailsIngredientsView(mealDetail: .MOCK_MEAL_DETAIL)
}
