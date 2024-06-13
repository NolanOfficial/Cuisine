//
//  EmptyMealsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct EmptyMealsView: View {
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment:.center, spacing: 16) {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
              
                VStack(spacing: 6) {
                    Text("No Recipes Found")
                        .font(.headline)

                    Text("No recipes were found. Try another category.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    EmptyMealsView()
}
