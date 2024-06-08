//
//  RecipeDetailsInstructionsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsInstructionsView: View {
    
    let mealDetail: MealDetail
    
    var body: some View {
        if let instructions = mealDetail.instructions {
            VStack {
                HStack {
                    Text("Instructions")
                        .font(.headline)
                    Spacer()
                }
                .padding(.bottom)
                
                Text(instructions)
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

#Preview {
    RecipeDetailsInstructionsView(mealDetail: .MOCK_MEAL_DETAIL)
}
