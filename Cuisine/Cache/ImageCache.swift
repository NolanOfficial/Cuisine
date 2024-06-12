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

    /// A cache object that stores a path string for each image
    private let cache = NSCache<NSString, UIImage>()

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
