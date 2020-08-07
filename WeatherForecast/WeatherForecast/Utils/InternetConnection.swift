//
//  InternetConnection.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 07/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import Foundation
import Alamofire

class InternetConnection {
    class func isConnectedToInternet() -> Bool {
        guard let manager = NetworkReachabilityManager() else{
            return false
        }
        return manager.isReachable
    }
}
