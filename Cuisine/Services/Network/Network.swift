//
//  Network.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import Foundation

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
        
        let (data, response) = try await urlSession.data(for: .cuisineRequest(url))
        
        guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
       
        // This would be seperated out with the corresponding server side errors
        // These codes are generic codes most commonly used
        guard httpResponse.statusCode == 200 else {
            switch httpResponse.statusCode {
            case 100..<200:
                throw URLError(.unknown)
            case 300..<400:
                throw URLError(.redirectToNonExistentLocation)
            case 400..<500:
                throw URLError(.fileDoesNotExist)
            case 500..<600:
                throw URLError(.badServerResponse)
            default:
                throw URLError(.unknown)
            }
        }
        return try cuisineDecoder.decode(T.self, from: data)
    }
}
