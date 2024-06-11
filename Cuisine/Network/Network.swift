//
//  Network.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import Foundation

/// Network protocol
protocol NetworkProtocol {
    func fetch<T: Decodable>(_ url: URL) async throws -> T
}

/// Handles all network requests
class Network: NetworkProtocol {
    
    /// Custom url session configuration
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .cuisineConfiguration) {
        self.urlSession = urlSession
    }
    
    /// A reusable meal service JSON decoder
    ///
    /// - Important: .convertFromSnakeCase is disabled since it's not actually used.
    /// This is to indicate how it would work if the json matched the model.
    private let cuisineDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// Retrieves and decodes the data from the given url
    ///
    /// - Parameter url: The url from where to retrieve the data
    ///
    /// - Returns: The decoded data
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        // Starting network session and getting a response
        let (data, response) = try await urlSession.data(for: .cuisineRequest(url))
        // Ensuring we have a valid response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        // Returning decoded data
        return try cuisineDecoder.decode(T.self, from: data)
    }
}
