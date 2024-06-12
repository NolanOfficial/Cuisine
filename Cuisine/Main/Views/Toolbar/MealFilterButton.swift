//
//  MealFilterButton.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct MealFilterButton: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        Menu {
            ForEach(MealFilter.allCases, id: \.self) { filter in
                Button {
                    viewModel.mealFilter = filter
                } label: {
                    HStack {
                        Text(LocalizedStringKey(filter.rawValue.capitalized))
                        Spacer()
                        if viewModel.mealFilter == filter {
                            Image(systemName: "arrow.down")
                        }
                    }
                }
                .accessibilityLabel("\(filter.rawValue.capitalized) Recipe Filter")
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
        .foregroundStyle(viewModel.mealFilter == .alphabetical ? .white : .orange)
        .accessibilityLabel("Recipe Filter Menu")
    }
}

#Preview {
    MealFilterButton(viewModel: MainViewModel())
}

