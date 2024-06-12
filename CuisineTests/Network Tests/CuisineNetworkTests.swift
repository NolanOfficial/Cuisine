//
//  CuisineNetworkTests.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/11/24.
//

import XCTest
@testable import Cuisine

final class CuisineNetworkTests: XCTestCase {
    
    /// URL session with no data saving or caching
    var urlSession: URLSession!
    
    /// Network
    var network: NetworkProtocol!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        network = Network(urlSession: urlSession)
    }
    
    /// Tests the the success of the network fetch method
    func test_Fetch_Meals_Success() async throws {
        
        // Fetching meal url from category
        guard let url = FetchAPI.meal(category: .dessert).url else { throw URLError(.badURL) }
        
        // Creating a mock response from the url
        guard let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: ["Content-Type": "application/json"]) else { throw URLError(.badServerResponse) }
        
        MockURLProtocol.requestHandler = { request in
            guard let mockData = MockDataJSON.mockMealsSuccessData.data(using: .utf8) else { throw URLError(.cannotDecodeRawData) }
            return (mockData, response)
        }
        
        let data: MealsResponse = try await network.fetch(url)
        
        XCTAssertEqual(data.meals.first?.name, "Battenberg Cake")
        XCTAssertEqual(data.meals.first?.thumbnailUrl, URL(string: "https://www.themealdb.com/images/media/meals/ywwrsp1511720277.jpg"))
        XCTAssertEqual(data.meals.first?.id, "52894")
    }
    
    /// Tests the the success of the network fetch method
    func test_Fetch_Meal_Details_Success() async throws {
        
        // Fetching meal url from category
        guard let url = FetchAPI.mealDetails(meal: Meal.MOCK_MEAL).url else { throw URLError(.badURL) }
        
        // Creating a mock response from the url
        guard let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: ["Content-Type": "application/json"]) else { throw URLError(.badServerResponse) }
        
        MockURLProtocol.requestHandler = { request in
            guard let mockData = MockDataJSON.mockMealDetailsData.data(using: .utf8) else { throw URLError(.cannotDecodeRawData) }
            return (mockData, response)
        }
        
        let data: MealDetailsResponse = try await network.fetch(url)
        
        XCTAssertEqual(data.meals.first?.name, "Battenberg Cake")
        XCTAssertEqual(data.meals.first?.area, "British")
        XCTAssertEqual(data.meals.first?.ingredientNine, "Butter")
        XCTAssertEqual(data.meals.first?.id, "52894")
    }
    
    /// Tests the the json failure of the network fetch method
    func test_Fetch_Data_Fail() async throws {
        
        // Fetching meal url from category
        guard let url = FetchAPI.meal(category: .dessert).url else { throw URLError(.badURL) }
        
        // Creating a mock response from the url
        guard let response = HTTPURLResponse(url: url,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: ["Content-Type": "application/json"]) else { throw URLError(.badServerResponse) }
        
        MockURLProtocol.requestHandler = { request in
            guard let mockData = MockDataJSON.mockMealsFailedData.data(using: .utf8) else { throw URLError(.cannotDecodeRawData) }
            return (mockData, response)
        }
        
        let expectation = expectation(description: "Incorrect JSON Format Error")
        
        do {
            let _: MealsResponse = try await network.fetch(url)
            XCTFail("The test should throw an unable to decode error.")
            expectation.fulfill()
        } catch let error as DecodingError {
            expectation.fulfill()
        } catch {
            XCTFail("The test should throw an unable to decode error.")
            expectation.fulfill()
        }
         
        await fulfillment(of: [expectation])
    }
    
    /// Tests the the json failure of the network fetch method
    func test_Fetch_Server_Fail() async throws {
        
        // Fetching meal url from category
        guard let url = FetchAPI.meal(category: .dessert).url else { throw URLError(.badURL) }
        
        // Creating a mock response from the url
        guard let response = HTTPURLResponse(url: url,
                                             statusCode: 404,
                                             httpVersion: nil,
                                             headerFields: ["Content-Type": "application/json"]) else { throw URLError(.badServerResponse) }
        
        MockURLProtocol.requestHandler = { request in
            guard let mockData = MockDataJSON.mockMealsFailedData.data(using: .utf8) else { throw URLError(.cannotDecodeRawData) }
            return (mockData, response)
        }
        
        let expectation = expectation(description: "Incorrect JSON Format Error")
        
        do {
            let _: MealsResponse = try await network.fetch(url)
            XCTFail("The test should throw a status coder / server error.")
            expectation.fulfill()
        } catch let error as URLError {
            if error == URLError(.badServerResponse) {
                expectation.fulfill()
            }
        } catch {
            XCTFail("The test should throw a status coder / server error.")
            expectation.fulfill()
        }
         
        await fulfillment(of: [expectation])
    }
}
