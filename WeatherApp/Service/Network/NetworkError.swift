//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

enum NetworkError: Error {
    case cantBuildUrlFromRequest
    case noInternetConnection
    case parsingFailure
    case networkError
    case timeout
}
