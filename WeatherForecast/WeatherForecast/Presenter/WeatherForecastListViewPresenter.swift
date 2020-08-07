//
//  ForecastWeatherListViewPresenter.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 06/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import UIKit

class WeatherForecastListViewPresenter: NSObject {
    
    weak private var view: ListWeatherProtocol?
    private let cache: Cache<String, [WeatherItem]>
    
    init(view: ListWeatherProtocol) {
        self.view = view
        self.cache = Cache<String, [WeatherItem]>()
    }
    
    /// Load weather forecast
    /// - Parameter city: city name
    func loadWeatherForecast(_ city: String) {
        
        // Check internet connection
        guard InternetConnection.isConnectedToInternet() else {
            self.view?.showReachabilityAlert()
            return
        }
        
        self.view?.startLoading()
        
        APIManager.shared.fetchForeCastWeatherFromCity(city, successCallback: { [weak self] weatherItems in
            guard let self = self else { return }
            self.view?.finishLoading()
            self.view?.refreshView(weatherItems)
        }) { [weak self] error in
            guard let self = self else { return }
            self.view?.finishLoading()
            self.view?.showDownloadErrorAlert(error: error)
        }
    }
}
