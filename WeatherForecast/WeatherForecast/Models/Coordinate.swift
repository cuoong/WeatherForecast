//
//  Coordinate.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

public struct Coordinate: Decodable {
    var lat: Double
    var lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}
