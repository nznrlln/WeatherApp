//
//  UserDefaultsService.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

/// Ключи для хранения в UserDefaults, через rawValue каждого из case'ов
enum UserDefaultsKeys: String {
    case currentCity
    case cities
    case citiesWeather
}


final class UserDefaultsService {

    // MARK: let/var

    /// Синглтон
    static let shared = UserDefaultsService()

    private let userDefaults = UserDefaults.standard

    /// Current city
    var currentCity: CityModel? {
        get {
            userDefaults.value(CityModel.self, forKey: UserDefaultsKeys.currentCity.rawValue)
        }
        set {
            userDefaults.set(encodable: newValue, forKey: UserDefaultsKeys.currentCity.rawValue)
        }
    }

    /// Array of all cities
    var cities: Set<CityModel> {
        get {
            userDefaults.value(Set<CityModel>.self, forKey: UserDefaultsKeys.cities.rawValue) ?? []
        }
        set {
            userDefaults.set(encodable: newValue, forKey: UserDefaultsKeys.cities.rawValue)
        }
    }

    /// Latest weather data for each city
    var citiesWeather: [String : CityWeatherModel]? {
        get {
             return userDefaults.value([String : CityWeatherModel].self, forKey: UserDefaultsKeys.citiesWeather.rawValue)
        }
        set {
            userDefaults.set(encodable: newValue, forKey: UserDefaultsKeys.citiesWeather.rawValue)
        }
    }

    /// Latest weather data for each city
//    var citiesWeather: [CityWeatherModel]? {
//        get {
//             return userDefaults.value([CityWeatherModel].self, forKey: UserDefaultsKeys.citiesWeather.rawValue)
//        }
//        set {
//            userDefaults.set(encodable: newValue, forKey: UserDefaultsKeys.citiesWeather.rawValue)
//        }
//    }

    private init() {}

}
