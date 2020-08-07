//
//  City.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

public struct City: Decodable {
    var id: Int
    var name: String
    var coordinate: Coordinate
    var country: String
    var population: Int
    var timezone: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coordinate = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
    }
}
