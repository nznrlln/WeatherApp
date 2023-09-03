//
//  NetworkRequest.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

//This is the `NetworkRequest` protocol you may implement other classes can conform
protocol NetworkRequest {
    associatedtype Response: Decodable

    var sheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var headers: [String : String] { get }
    var httpMethod: HTTPMethod { get }
}
