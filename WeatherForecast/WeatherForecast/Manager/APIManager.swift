//
//  APIManager.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import UIKit
import Alamofire

let API_FORECAST_WEATHER_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?"
let API_KEY = "60c6fbeb4b93ac653c492ba806fc346d"

class APIManager: NSObject {
    static internal let shared = APIManager()
    private let cache = Cache<String, [WeatherItem]>()
    
    
    /// Generate link URL to request forecase weather
    /// - Parameters:
    ///   - city: city name
    ///   - cnt: number of weather in list
    class func generateForecastWeatherRequestURL(_ city: String, cnt: String) -> URL? {
        guard var components = URLComponents(string: API_FORECAST_WEATHER_URL) else { return nil }
        
        components.queryItems = [URLQueryItem(name: "q", value: city), URLQueryItem(name: "cnt", value: cnt), URLQueryItem(name: "appid", value: API_KEY), URLQueryItem(name: "units", value: "metric")]
        
        return components.url
    }
    
    /// Request forcecast data from server
    /// - Parameters:
    ///   - city: String
    ///   - successCallback: callback block when request success
    ///   - errorCallback: callback block when request got an error
    /// - Returns: Void
    func fetchForeCastWeatherFromCity(_ city: String, successCallback: @escaping (_ weatherForecast : [WeatherItem]) -> (), errorCallback: @escaping (_ error : Error) -> ()) {
        
        guard let weatherItems = self.cache.value(forKey: city.lowercased()) else {
            guard let urlRequest = APIManager.generateForecastWeatherRequestURL(city, cnt: "7") else { return }
            AF.request(urlRequest).responseDecodable(of: WeatherForecast.self, completionHandler: { response in
                switch response.result {
                case .success:
                    guard let weatherForecast = response.value else { return }
                    self.cache.insert(weatherForecast.listWeatherItems, forKey: city.lowercased(), lifeTime: self.cacheLifeTime())
                    successCallback(weatherForecast.listWeatherItems)
                case .failure:
                    guard let error = response.error?.underlyingError else { return }
                    errorCallback(error)
                    break
                }
            })
            return
        }
        successCallback(weatherItems)
    }
}

extension APIManager {
    private func cacheLifeTime() -> TimeInterval {
        let now = Date()
        let nowSince1970 = now.timeIntervalSince1970
        let calendar = Calendar.current
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: now) else {
            return 0
        }
        let lastSecondOfToday = calendar.startOfDay(for: tomorrow).timeIntervalSince1970 - 1
        return lastSecondOfToday - nowSince1970
    }
}

