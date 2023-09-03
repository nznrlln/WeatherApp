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

//    var spacing: CGFloat {
//        switch self {
//        case .currentWeather:
//            return 0
//        case .hourForecast:
//            return 8
//        case .dateForecast:
//            return 8
//        }
//    }

//    var columnCount: Int {
//        switch self {
//        case .ads:
//            return 2
//        }
//    }
//
//    var itemFractionalWidth: CGFloat {
//        switch self {
//        case .currentWeather:
//            return 1.0
//        }
//    }

//    var estimatedItemHeight: CGFloat {
//        switch self {
//        case .c:
//            return 275
//        }
//    }
//
//    var spacing: CGFloat {
//        switch self {
//        case .ads:
//            return 8
//        }
//    }

}
