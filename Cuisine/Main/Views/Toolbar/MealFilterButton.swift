//
//  MealFilterButton.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct MealFilterButton: View {
    
    @Binding var mealFilter: MealFilter
    
    var body: some View {
        Menu {
            ForEach(MealFilter.allCases, id: \.self) { filter in
                Button {
                    mealFilter = filter
                } label: {
                    HStack {
                        Text(LocalizedStringKey(filter.rawValue.capitalized))
                        Spacer()
                        if mealFilter == filter {
                            Image(systemName: "arrow.down")
                        }
                    }
                }
                .accessibilityLabel("\(filter.rawValue.capitalized) Recipe Filter")
            }
        } label: {
            Image(systemName: "slider.horizontal.3")
        }
        .foregroundStyle(mealFilter == .alphabetical ? .white : .orange)
        .accessibilityLabel("Recipe Filter Menu")
    }
}

#Preview {
    @State var filter: MealFilter = .alphabetical
    MealFilterButton(mealFilter: $filter)
}

