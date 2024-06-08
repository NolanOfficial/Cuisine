//
//  ImageCache.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

// Using a simple custom cache for images
// 3rd party caches like Nuke or KingFisher are also other options
class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}

struct RemoteImage: View {
    @ObservedObject var imageLoader: ImageLoader

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

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: URL?
    private var task: URLSessionDataTask?

    init(url: URL?) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        
        guard let url else { return }
        
        if let cachedImage = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                    ImageCache.shared.set(image, forKey: url.absoluteString)
                }
            }
        }
        task?.resume()
    }
}
