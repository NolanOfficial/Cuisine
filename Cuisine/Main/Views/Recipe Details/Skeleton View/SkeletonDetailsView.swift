//
//  SkeletonDetailsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/8/24.
//

import SwiftUI

struct SkeletonDetailsView: View {
    
    @State private var isAnimating = false
    
    private let center = (UIScreen.main.bounds.width / 2) + 250
    
    private func skeletonView() -> some View {
        return VStack(spacing: 22) {
            
            HStack {
                Text("Lorem Impsum")
                    .sectionTitle()
                Spacer()
            }
           
            ForEach(0..<7) { _ in
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(.quaternary)
                        .frame(width: 15, height: 15)
                    
                    HStack {
                        Text("Lorem ipsum")
                            .font(.subheadline.weight(.semibold))
                        Spacer()
                        Text("Lorem ipsum dolor sit")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
        }
        .redacted(reason: .placeholder)
        .padding()
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
    SkeletonDetailsView()
}
