//
//  WeatherItem.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import UIKit

public struct WeatherItem: Decodable {
    var dt: Int
    var temp: Temperature
    var pressure: Int
    var humidity: Int
    var weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case temp = "temp"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
    }
    
}

