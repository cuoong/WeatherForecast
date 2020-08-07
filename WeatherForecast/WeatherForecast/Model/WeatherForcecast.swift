//
//  WeatherForcecast.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

public struct WeatherForecast: Decodable {
    var city: City
    var listWeatherItems: [WeatherItem]
    
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case listWeatherItems = "list"
    }
}
