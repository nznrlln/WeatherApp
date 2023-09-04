//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

final class CurrentWeatherRequest: WeatherRequest {
    typealias Response = CurrentWeatherJSONData

    let path = "/current"
    let queryItems: [URLQueryItem]

    init(lon: String, lat: String) {
        self.queryItems = [
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "lang", value: "ru")
        ]
    }
}
