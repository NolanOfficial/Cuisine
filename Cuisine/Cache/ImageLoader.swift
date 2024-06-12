//
//  ImageLoader.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import SwiftUI

/// Class the handles all image loading and cache data
@MainActor
class ImageLoader: ObservableObject {
    
    private let imageCache = ImageCache()
    
    /// Optional image to retrieve
    @Published var image: UIImage?
    
    /// Optional image error thrown
    @Published var imageError: Error?

    /// The URL to get or set
    private var url: URL?

    /// Initializes the cache retrieval from the given url
    ///
    /// - Parameter url: The url path for a cache lookup
    init(url: URL?) {
        self.url = url
      
        Task {
            do {
                try await loadImage()
            } catch {
                // This is not an error we want to show the user directly.
                imageError = error
            }
        }
    }

    /// Loads image from cache, if available, or sets new image asynchronosuly into the cache
    private func loadImage() async throws {
        
        guard let url else { throw URLError(.badURL) }
        
        if let cachedImage = imageCache.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        // Custom URL session for downloading the data
        let (data, _) = try await URLSession.cuisineConfiguration.data(for: .cuisineRequest(url))
        
        // Setting the image and cache path, if available
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
        self.image = image
        imageCache.set(image, forKey: url.absoluteString)
    }
}
