//
//  RecipeDetailsInstructionsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsInstructionsView: View {
    
    let instructions: String
    
    var body: some View {
        Text(instructions)
            .font(.subheadline)
            .padding(.horizontal)
    }
}

#Preview {
    RecipeDetailsInstructionsView(instructions: MealDetail.MOCK_MEAL_DETAIL.instructions ?? "No Mock Data")
}
