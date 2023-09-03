//
//  AdsRequest.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

//enum ForecastRequestType {
//    case current
//    case forecast5d3h
//    case forecast16d
//}

protocol WeatherRequest: NetworkRequest {}

extension WeatherRequest {
    var sheme: String { "https" }
    var host: String { "weatherbit-v1-mashape.p.rapidapi.com" }
    var headers: [String: String] {[
        "X-RapidAPI-Key": "31cd180094msheb5e6fc204d8e5ap125d5ejsn6610bfc143e8", // first account
//        "X-RapidAPI-Key": "2d130e4cdemsh73765ff29163795p1b1972jsnd1bb44fd8915", // second account
        "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
    ]}
    var httpMethod: HTTPMethod { .GET }
}
