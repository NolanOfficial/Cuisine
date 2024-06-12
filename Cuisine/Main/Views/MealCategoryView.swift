//
//  MealCategoryView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct MealCategoryView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        HStack {
            Text("Categories")
                .font(.headline)
            
            Text(viewModel.selectedCategory.rawValue.capitalized.localized)
                .roundedRectBackground()
        }
        .listRowSeparator(.hidden)
        
        // ScrollView since we have a known small set number of items
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(alignment: .bottom, spacing: 24) {
                
                ForEach(MealCategory.allCases, id: \.self) { cuisine in
                    
                    Button {
                        viewModel.selectedCategory = cuisine
                    } label: {
                        VStack {
                            Image(cuisine.rawValue)
                                .resizable()
                                .frame(width: 35, height: 35)
                                .padding(6)
                            
                            Text(cuisine.rawValue.capitalized.localized)
                                .font(.footnote)
                        }
                        .foregroundStyle(viewModel.selectedCategory == cuisine ? .orange : .primary)
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
    MealCategoryView(viewModel: MainViewModel())
}
