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

extension NetworkError {
    var message: String {
        switch self {
        case .cantBuildUrlFromRequest:
            return "Ошибка запроса"
        case .parsingFailure:
            return "Ошибка парсинга"
        case .noInternetConnection, .timeout:
            return "Нет связи"
        default:
            return "Неизвестная ошибка"
        }
    }
}

