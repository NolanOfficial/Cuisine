//
//  SectionTitle.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import SwiftUI

struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowInsets(.zero)
            .listRowSeparator(.hidden)
            .font(.headline)
            .foregroundStyle(.primary)
            .padding(.horizontal)
            .padding(.vertical, 10)
    }
}
