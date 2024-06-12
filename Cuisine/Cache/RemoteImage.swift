//
//  RemoteImage.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import SwiftUI

/// View that automatically initializes the image cache
struct RemoteImage: View {
    
    /// An observed image loader
    @ObservedObject var imageLoader: ImageLoader

    /// Initialized the image loader with the given url
    ///
    /// - Parameter url: The url in which to initialize the image loader
    init(url: URL?) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(.regularMaterial)
        }
    }
}
