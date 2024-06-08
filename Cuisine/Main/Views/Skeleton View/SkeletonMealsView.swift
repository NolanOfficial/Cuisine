//
//  SkeletonMealsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct SkeletonMealsView: View {
    
    @State private var isAnimating = false
    
    private let center = (UIScreen.main.bounds.width / 2) + 250
    
    private func skeletonView() -> some View {
        return VStack(spacing: 22) {
            ForEach(0..<5) { _ in
                HStack(spacing: 10) {
                   
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.quaternary)
                        .frame(width: 120, height: 75)
                    
                    VStack(alignment: .leading) {
                        Text("Lorem Ipsum")
                            .font(.subheadline.weight(.semibold))
                        Text("Lorem Ipsum")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } 
                }
            }
        }.redacted(reason: .placeholder)
    }
    
    var body: some View {
        skeletonView()
            .overlay {
                skeletonView()
                    .mask {
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: .init(colors: [.clear, .white, .clear]), startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: UIScreen.main.bounds.height)
                            .rotationEffect(.degrees(90))
                            .offset(x: isAnimating ? center : -center)
                }
            }
            .onAppear {
                withAnimation(.easeInOut.speed(0.2).repeatForever(autoreverses: false)) {
                    isAnimating.toggle()
                }
            }
    }
}

#Preview {
    SkeletonMealsView()
}
