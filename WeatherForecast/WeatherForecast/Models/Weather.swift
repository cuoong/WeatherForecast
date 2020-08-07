//
//  Weather.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 05/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

public struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}
