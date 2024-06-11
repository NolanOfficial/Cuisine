//
//  RoundedRectBackground.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RoundedRectBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 12)
            .font(.footnote.weight(.semibold))
            .padding(6)
            .foregroundStyle(.orange)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
