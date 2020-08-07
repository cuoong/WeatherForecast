//
//  WeatherForecastListViewPresenterTest.swift
//  WeatherForecastTests
//
//  Created by Cuong Nguyen on 07/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastListViewPresenterTest: XCTestCase {
    
    var weatherForecastListViewPresenter: WeatherForecastListViewPresenter!
    let viewController = MockWeatherForeCastViewController()
    var mockAPIManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()
        self.weatherForecastListViewPresenter = WeatherForecastListViewPresenter(view: viewController)
        mockAPIManager = MockAPIManager()
        weatherForecastListViewPresenter.apiManager = mockAPIManager
    }
    
    func testLoadWeatherForecast() {
        weatherForecastListViewPresenter.loadWeatherForecast("hanoi")
        XCTAssertEqual(mockAPIManager.logs.first?.city, "hanoi")
        XCTAssertEqual(mockAPIManager.logs.first?.name, "fetchForeCastWeatherFromCity")
    }
}

class MockAPIManager: APIManager {
    
    var logs = [(city: String, name: String)]()
    
    override func fetchForeCastWeatherFromCity(_ city: String, successCallback: @escaping ([WeatherItem]) -> (), errorCallback: @escaping (Error) -> ()) {
        logs.append((city: city, name: "fetchForeCastWeatherFromCity"))
        
    }
}

class MockWeatherForeCastViewController: WeatherForeCastViewController {
    
    var logs = [String]()
    override func finishLoading() {
        logs.append("finishLoading")
    }
    
    override func refreshView(_ listWeather: [WeatherItem]?) {
        logs.append("refreshView")
    }
}
