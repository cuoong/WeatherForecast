//
//  Date+Formatter.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 06/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        let dateStr = formatter.string(from: self)
        return dateStr
    }
}
