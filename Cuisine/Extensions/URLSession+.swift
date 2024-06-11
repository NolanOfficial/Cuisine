//
//  URLSession+.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/9/24.
//

import Foundation

extension URLSession {
    
    /// Custom URL Session that enables `waitForConnectivity` and `urlCache`
    ///
    /// - Note: This could also be created within a custom network layer
    /// (on top of the service layer)
    static var cuisineConfiguration: URLSession {
        // Custom url session config
        let configuration = URLSessionConfiguration.default
        
        // TCP
        // (note: disabled since this needs to be enabled server side as well)
//        configuration.multipathServiceType = .handover
        
        // Wait for connectivity with timeout
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 15
        
        // URL Cache
        // Default capcity values but can increase
        let memoryCapacity = 4 * 1024 * 1024 // 4 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
        configuration.urlCache = urlCache
        
        return URLSession(configuration: configuration)
    }
}
