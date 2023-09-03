//
//  URLRequestBuilder.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

protocol IURLRequestBuilder: AnyObject {
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError>
}

final class URLRequestBuilder: IURLRequestBuilder {
    
    // MARK: - IURLRequestBuilder
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError> {

        var urlComponents = URLComponents()
        urlComponents.scheme = request.sheme
        urlComponents.host = request.host
        urlComponents.path = request.path
        urlComponents.queryItems = request.queryItems

        guard let url = urlComponents.url else {
            return .failure(.cantBuildUrlFromRequest)
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 15)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        return .success(urlRequest)
    }
    
}
