//
//  FetchForecastFromServerTests.swift
//  OpenWeatherChallengeTests
//
//  Created by Miguel Santiago Rodríguez on 8/1/18.
//  Copyright © 2018 Miguel Santiago Rodríguez. All rights reserved.
//

import XCTest

@testable import OpenWeatherChallenge

class ParsersTests: XCTestCase {
    
    func testShouldParseSingleWeatherJSON() {
        let sut = JSONWeatherParser()
        let weather = sut.parse(info: Mocks.singleWeatherJSON)
        XCTAssertEqual(weather?.temperature, 286.67)
        XCTAssertEqual(weather?.date, Date(timeIntervalSince1970: TimeInterval(1487246400)))
    }
    
    func testShouldParseSingleWeatherCSV() {
        let sut = CSVWeatherParser()
        let weather = sut.parse(info: Mocks.singleWeatherCSV)
        XCTAssertEqual(weather?.temperature, 286.67)
        XCTAssertEqual(weather?.date, Date(timeIntervalSince1970: TimeInterval(1487246400)))
    }
    
    func testShouldParseAllWeatherJSON() {
        let sut = JSONWeatherParser()
        let weatherList = sut.parse(Mocks.allWeatherJSON)
        XCTAssertEqual(weatherList?.count, 36)
    }
    
    func testShouldParseAllWeatherCSV() {
        let sut = CSVWeatherParser()
        let weatherList = sut.parse(Mocks.allWeatherCSV)
        XCTAssertEqual(weatherList?.count, 5)
    }
}
