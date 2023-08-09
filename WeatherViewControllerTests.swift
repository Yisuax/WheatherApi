//
//  WeatherViewControllerTests.swift
//  WeatherViewControllerTests
//
//  Created by Jesus Jimenez on 10/06/23.
//

import XCTest
@testable import WeatherAPI

class WeatherViewControllerTests: XCTestCase {
    
    var viewController: WeatherViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchWeatherData(for city: String) {
        // Invoke the fetchWeatherData() method
        let city = "London"
        
        viewController.fetchWeatherData(for: city)

        
        // Wait for the asynchronous request to complete (if applicable)
        // You can use XCTestExpectation to handle asynchronous operations
        
        // Perform your assertions here
        // For example, you can check if the weather property and its properties are updated correctly
        
        XCTAssertNotNil(viewController.weather)
        XCTAssertNotNil(viewController.weather?.locationName)
        XCTAssertNotNil(viewController.weather?.conditionText)
        XCTAssertNotNil(viewController.weather?.localTime)
        XCTAssertNotNil(viewController.weather?.temperatureCelsius)
        XCTAssertNotNil(viewController.weather?.temperatureFahrenheit)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
