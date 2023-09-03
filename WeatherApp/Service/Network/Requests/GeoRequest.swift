//
//  ProductRequest.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

final class GeoRequest: NetworkRequest {
    typealias Response = GeoModel

    let sheme = "http"
    let host = "geocode-maps.yandex.ru"
    let path = "/1.x"
    let queryItems: [URLQueryItem]
    let headers: [String : String] = [:]
    let httpMethod: HTTPMethod = .GET

    init(locationName: String) {
        self.queryItems = [
            URLQueryItem(name: "apikey", value: "ff7239e6-7563-42d0-9446-93515a1bd757"),
            URLQueryItem(name: "geocode", value: locationName),
            URLQueryItem(name: "kind", value: "locality"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "1"),
        ]
    }

    init(lon: String, lat: String) {
        self.queryItems = [
            URLQueryItem(name: "apikey", value: "ff7239e6-7563-42d0-9446-93515a1bd757"),
            URLQueryItem(name: "geocode", value: "\(lon),\(lat)"),
            URLQueryItem(name: "kind", value: "locality"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "results", value: "1"),
        ]
    }


}
