//
//  EmptyDetailsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/8/24.
//

import SwiftUI

struct EmptyDetailsView: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment:.center, spacing: 16) {
                
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
              
                VStack(spacing: 6) {
                    
                    Text("Recipe Details Error")
                        .font(.headline)

                    Text("Unable to load recipe. Please try again.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    EmptyDetailsView()
}
