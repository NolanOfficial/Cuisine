//
//  MealCategoryView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct MealCategoryView: View {
    
    @Binding var category: MealCategory
    
    var body: some View {
        HStack {
            Text("Categories")
            
            Text(category.rawValue.capitalized.localized)
                .roundedRectBackground()
        }
        .sectionTitle()
        
        // ScrollView since we have a known small set number of items
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .bottom, spacing: 24) {
                
                ForEach(MealCategory.allCases, id: \.self) { cuisine in
                    
                    Button {
                        category = cuisine
                    } label: {
                        VStack {
                            Image(cuisine.rawValue)
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(6)
                            
                            Text(cuisine.rawValue.capitalized.localized)
                                .font(.footnote)
                        }
                        .foregroundStyle(category == cuisine ? .orange : .primary)
                    }
                    .accessibilityIdentifier("\(cuisine.rawValue.capitalized) Meal Category")
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.top, 8)
        }
        .listRowInsets(.zero)
    }
}

#Preview {
    MealCategoryView(category: .constant(.breakfast))
}
