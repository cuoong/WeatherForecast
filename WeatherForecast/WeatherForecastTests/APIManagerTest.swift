//
//  APIManagerTest.swift
//  WeatherForecastTests
//
//  Created by Cuong Nguyen on 06/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import XCTest
import Alamofire
@testable import WeatherForecast

class APIManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGenerateForecastWeatherRequestURL() {
        let city = "Hanoi"
        let cnt = "7"
        let urlRequest = APIManager.generateForecastWeatherRequestURL(city, cnt: cnt)
        XCTAssertEqual(urlRequest?.absoluteString, "https://api.openweathermap.org/data/2.5/forecast/daily?q=Hanoi&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric")
    }
    
    func testFetchForeCastWeatherFromCity() {
        guard let urlRequest = APIManager.generateForecastWeatherRequestURL("Hanoi", cnt: "7") else { return }
        let request = AF.request(urlRequest,method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        let expect = expectation(description: "The result is matching with result")
        request.responseDecodable(of: WeatherForecast.self) { response in
            switch response.result {
            case .success:
                XCTAssertNotNil(response.value)
                XCTAssertNil(response.error?.underlyingError)
                expect.fulfill()
            case .failure:
                XCTFail("Reponse failed: \(String(describing: response.error?.localizedDescription))")
                expect.fulfill()
            }
        }
        
        //wait for some time for the expectation
        waitForExpectations(timeout: 50, handler: { (error) in
            if let error = error {
                print("Failed : \(error.localizedDescription)")
            }
        })
    }

}
