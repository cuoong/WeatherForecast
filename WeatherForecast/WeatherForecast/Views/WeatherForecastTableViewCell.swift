//
//  WeatherForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by Cuong Nguyen on 06/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avgTemperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateValueLabel: UILabel!
    @IBOutlet weak var avgTemperatureValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    
    var weatherItem: WeatherItem? {
        didSet {
            updateCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureFonts()
    }
    
    func configureFonts() {
        dateLabel.adjustsFontForContentSizeCategory = true
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        
        avgTemperatureLabel.adjustsFontForContentSizeCategory = true
        avgTemperatureLabel.font = .preferredFont(forTextStyle: .footnote)
        
        pressureLabel.adjustsFontForContentSizeCategory = true
        pressureLabel.font = .preferredFont(forTextStyle: .footnote)
        
        humidityLabel.adjustsFontForContentSizeCategory = true
        humidityLabel.font = .preferredFont(forTextStyle: .footnote)
        
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = .preferredFont(forTextStyle: .footnote)
        
        dateValueLabel.adjustsFontForContentSizeCategory = true
        dateValueLabel.font = .preferredFont(forTextStyle: .footnote)
        
        avgTemperatureValueLabel.adjustsFontForContentSizeCategory = true
        avgTemperatureValueLabel.font = .preferredFont(forTextStyle: .footnote)
        
        pressureValueLabel.adjustsFontForContentSizeCategory = true
        pressureValueLabel.font = .preferredFont(forTextStyle: .footnote)
        
        humidityValueLabel.adjustsFontForContentSizeCategory = true
        humidityValueLabel.font = .preferredFont(forTextStyle: .footnote)
        
        descriptionValueLabel.adjustsFontForContentSizeCategory = true
        descriptionValueLabel.font = .preferredFont(forTextStyle: .footnote)
    }
    
    func updateCell() {
        guard let weatherItem = weatherItem else { return }
        
        let timestamp = weatherItem.dt
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        dateValueLabel.text = date.toString()
        
        let temperatureMin = weatherItem.temp.min
        let temperatureMax = weatherItem.temp.max
        let avgTemperature = ((temperatureMin + temperatureMax) / 2)
        let avgTempString = String(format: "%.1f", avgTemperature)
        avgTemperatureValueLabel.text = avgTempString + "°C"
        
        let pressure = weatherItem.pressure
        pressureValueLabel.text = String(pressure)
        
        let humidity = weatherItem.humidity
        humidityValueLabel.text = String(humidity) + "%"
        
        let weatherDescription = weatherItem.weather.first?.description
        descriptionValueLabel.text = weatherDescription
    }
}
