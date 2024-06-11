//
//  ImageCache.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

/// A simple custom cache for images
///
/// - Note: 3rd party caches like Nuke or KingFisher are also other options
class ImageCache {
    
    /// Shared singleton
    static let shared = ImageCache()

    /// A cache object that stores a path string for each image
    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    /// Sets a path with the given key for the given image
    ///
    /// - Parameter image: UImage to cache
    /// - Parameter forKey: String that sets the path
    ///
    /// - Important: Ensure the key is the url path for synchronization purposes.
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    /// Sets a path with the given key for the given image
    ///
    /// - Parameter key: String path in which the cache
    ///
    /// - Important: Ensure the key is the url path for synchronization purposes.
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

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

/// Class the handles all image loading and cache data
@MainActor
class ImageLoader: ObservableObject {
    
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
        
        if let cachedImage = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        // Custom URL session for downloading the data
        let (data, _) = try await URLSession.cuisineConfiguration.data(for: .cuisineRequest(url))
        
        // Setting the image and cache path, if available
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
        self.image = image
        ImageCache.shared.set(image, forKey: url.absoluteString)
    }
}
