//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct WeatherForecast1dModel: Codable {
    let forecastDate: String
    let humidity: Int
    let temperatureMin: Double
    let temperatureMax: Double
    let weather: WeatherModel

    enum CodingKeys: String, CodingKey {
        case forecastDate = "valid_date"
        case humidity = "rh"
        case temperatureMin = "min_temp"
        case temperatureMax = "high_temp"
        case weather
    }
}
