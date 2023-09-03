//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

struct WeatherModel: Codable {
    let description: String
    let iconCode: String

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case iconCode = "icon"
    }
}
