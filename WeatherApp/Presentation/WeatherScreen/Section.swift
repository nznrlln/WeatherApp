//
//  Section.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

enum Section: Int {

    case currentWeather
    case hourForecast
    case dateForecast

    var numberOfItems: Int {
        switch self {
        case .currentWeather:
            return 1
        case .hourForecast:
            return 8
        case .dateForecast:
            return 16
        }
    }
}
