//
//  WeatherForecast3hModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct WeatherForecast3hModel: Codable  {
    let forecastTime: String
    let temperature: Double
    let weather: WeatherModel

    enum CodingKeys: String, CodingKey {
        case forecastTime = "timestamp_local"
        case temperature = "temp"
        case weather
    }
}
