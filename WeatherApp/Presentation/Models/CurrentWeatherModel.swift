//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let temperature: Double
    let weather: WeatherModel

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case weather = "weather"
    }
}
