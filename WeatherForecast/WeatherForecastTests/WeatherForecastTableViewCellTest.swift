//
//  WeatherForecastTableViewCellTest.swift
//  WeatherForecastTests
//
//  Created by Cuong Nguyen on 07/08/2020.
//  Copyright © 2020 Cuong Nguyen. All rights reserved.
//

import XCTest
@testable import WeatherForecast

class WeatherForecastTableViewCellTest: XCTestCase {
    var tableViewCell: WeatherForecastTableViewCell!
    
    var dateLabel = UILabel()
    var avgTemperatureLabel = UILabel()
    var pressureLabel = UILabel()
    var humidityLabel = UILabel()
    var descriptionLabel = UILabel()
    
    var dateValueLabel = UILabel()
    var avgTemperatureValueLabel = UILabel()
    var pressureValueLabel = UILabel()
    var humidityValueLabel = UILabel()
    var descriptionValueLabel = UILabel()
    
    override func setUp() {
        super.setUp()
        tableViewCell = WeatherForecastTableViewCell()
        
        tableViewCell.dateLabel = dateLabel
        tableViewCell.avgTemperatureLabel = avgTemperatureLabel
        tableViewCell.pressureLabel = pressureLabel
        tableViewCell.humidityLabel = humidityLabel
        tableViewCell.descriptionLabel = descriptionLabel
        
        tableViewCell.dateValueLabel = dateValueLabel
        tableViewCell.avgTemperatureValueLabel = avgTemperatureValueLabel
        tableViewCell.pressureValueLabel = pressureValueLabel
        tableViewCell.humidityValueLabel = humidityValueLabel
        tableViewCell.descriptionValueLabel = descriptionValueLabel
    }
    
    func testUpdateCell() {
        let temperature = Temperature(day: 31.0, min: 26.41, max: 31, night: 26.41, eve: 29.96, morn: 31)
        let weather = Weather(id: 501, main: "Rain", description: "moderate rain", icon: "10d")
        let weatherItem = WeatherItem(dt: 1596772800, temp: temperature, pressure: 1005, humidity: 66, weather: [weather])
            
        tableViewCell.weatherItem = weatherItem
    
        XCTAssertNotNil(tableViewCell.weatherItem)
        XCTAssertEqual(tableViewCell.dateValueLabel.text, "Fri, 07 Aug 2020")
        XCTAssertEqual(tableViewCell.avgTemperatureValueLabel.text, "28.7°C")
        XCTAssertEqual(tableViewCell.pressureValueLabel.text, "1005")
        XCTAssertEqual(tableViewCell.humidityValueLabel.text, "66%")
        XCTAssertEqual(tableViewCell.descriptionValueLabel.text, "moderate rain")
    }
    
    func testConfigureFonts() {
        tableViewCell.configureFonts()
        XCTAssertTrue(dateLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(dateLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(dateValueLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(dateValueLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(avgTemperatureLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(avgTemperatureLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(avgTemperatureValueLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(avgTemperatureValueLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(pressureLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(pressureLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(pressureValueLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(pressureValueLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(humidityLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(humidityLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(humidityValueLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(humidityValueLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(descriptionLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(descriptionLabel.font, .preferredFont(forTextStyle: .footnote))
        
        XCTAssertTrue(descriptionValueLabel.adjustsFontForContentSizeCategory)
        XCTAssertEqual(descriptionValueLabel.font, .preferredFont(forTextStyle: .footnote))
    }
}
