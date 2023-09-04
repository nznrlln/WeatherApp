//
//  CityModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

struct CityModel: Codable, Hashable {
    let city: String
    let country: String
    let lon: String
    let lat: String

    var uid: String

    enum CodingKeys: String, CodingKey {
        case city
        case country
        case lon
        case lat
        case uid
    }
}
