//
//  RecipeDetailsAboutView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsAboutView: View {
    
    let mealDetail: MealDetail
    
    var body: some View {

        HStack {
            Text("About")
                .font(.headline)
            Spacer()
        }
        .padding()
            
        ForEach(Array(mealDetail.aboutMap.keys).sorted(by: { $0 < $1 }), id: \.self) { about in
                
            if let aboutEnum = MealDetailAbout(rawValue: about), let detail = mealDetail.aboutMap[about] {
                HStack {
                    Image(systemName: aboutEnum.imageName)
                        .imageScale(.large)
                    
                    Text(about.capitalized)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    if aboutEnum == .website || aboutEnum == .youtube {
                        if let url = URL(string: detail) {
                            Link(destination: url) {
                                Text(detail)
                                    .font(.subheadline)
                                    .roundedRectBackground()
                            }
                        }
                    } else {
                        Text(detail)
                            .font(.subheadline)
                            .roundedRectBackground()
                    }
                }
                .padding(.horizontal)
                .padding(6)
            }
        }
    }
}

#Preview {
    RecipeDetailsAboutView(mealDetail: .MOCK_MEAL_DETAIL)
}
