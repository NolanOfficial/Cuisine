//
//  URLRequest+.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/9/24.
//

import Foundation

extension URLRequest {
    
    /// Custom URL Request that enables and returns cached urls
    ///
    /// - Parameter url: The url in which to make the request for
    static func cuisineRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        return request
    }
}
