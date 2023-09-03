//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct CurrentWeatherModel: Codable {
    let temperature: Double
//    let temperatureMin: Double
//    let temperatureMax: Double
    let weather: WeatherModel

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
//        case temperatureMin
//        case temperatureMax
        case weather = "weather"
    }
}
