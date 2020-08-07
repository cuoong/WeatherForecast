//
//  CacheTest.swift
//  WeatherForecastTests
//
//  Created by Cuong Nguyen on 07/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class CacheTest: XCTestCase {
    
    var cache: Cache<String, [WeatherItem]>!
    
    override func setUp() {
        super.setUp()
        cache = Cache<String, [WeatherItem]>()
    }
    
    func testRemoveExpiredValue() {
        let temperature = Temperature(day: 31.0, min: 26.41, max: 31, night: 26.41, eve: 29.96, morn: 31)
        let weather = Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
        let weatherItem = WeatherItem(dt: 1596772800, temp: temperature, pressure: 1005, humidity: 66, weather: [weather])
        
        let cityName = "hanoi"
        cache.insert([weatherItem], forKey: cityName, lifeTime: 2)
        sleep(3)
        let value = cache.value(forKey: cityName)
        XCTAssertNil(value)
    }
}

