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


//final class CurrentWeatherRequest: NetworkRequest {
//    typealias Response = CurrentWeatherJSONData
//
//    let sheme = "https"
//    let host = "weatherbit-v1-mashape.p.rapidapi.com"
//    let path = "/current"
//    let headers: [String: String]? {[
//        "X-RapidAPI-Key": "31cd180094msheb5e6fc204d8e5ap125d5ejsn6610bfc143e8", // first account
//    //        "X-RapidAPI-Key": "2d130e4cdemsh73765ff29163795p1b1972jsnd1bb44fd8915", // second account
//        "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
//    ]}
//    var httpMethod: HTTPMethod { .GET }
//    let queryItems: [URLQueryItem]
//
//    init(lon: String, lat: String) {
//        self.queryItems = [
//            URLQueryItem(name: "lon", value: lon),
//            URLQueryItem(name: "lat", value: lat),
//            URLQueryItem(name: "units", value: "metric"),
//            URLQueryItem(name: "lang", value: "ru")
//        ]
//    }
//}
