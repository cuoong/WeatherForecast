//
//  Temperature.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

public struct Temperature: Decodable {
    var day: Double
    var min: Double
    var max: Double
    var night: Double
    var eve: Double
    var morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }
}
