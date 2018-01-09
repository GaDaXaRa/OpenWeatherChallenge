//
//  WeatherRepositoryTests.swift
//  OpenWeatherChallengeTests
//
//  Created by Miguel Santiago Rodríguez on 9/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import OpenWeatherChallenge

class WeatherRepositoryTests: XCTestCase {
    
    func testShouldReturnDayForecast() {
        let sut = WeatherRepository<CSVWeatherParser, DiskCSVProvider>()
        let sutExpectation = expectation(description: "fetch forecast expectation")
        
        sut.fetchForecast { (forecasts) in
            XCTAssertTrue(forecasts!.first!.day < forecasts![1].day)
            XCTAssertTrue(forecasts!.first!.forecast.first!.date < forecasts!.first!.forecast[1].date)
            sutExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
}
