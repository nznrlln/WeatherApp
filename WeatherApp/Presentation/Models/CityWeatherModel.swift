//
//  CityWeatherModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct CityWeatherModel: Codable {
    var currentWeather: CurrentWeatherModel? = nil
    var forecast24h: [WeatherForecast3hModel]? = nil
    var forecast16d: [WeatherForecast1dModel]? = nil

    enum CodingKeys: String, CodingKey {
        case currentWeather
        case forecast24h
        case forecast16d
    }
}
