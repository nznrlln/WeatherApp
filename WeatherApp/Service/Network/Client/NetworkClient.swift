//
//  NetworkClient.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

protocol INetworkClient: AnyObject {
    func getData<Request: NetworkRequest>(from request: Request) async -> Result<Request.Response, NetworkError>
}

final class NetworkClient: INetworkClient {

    // MARK: - Properties
    private let urlSession: URLSession = URLSession.shared

    // MARK: - Dependencies
    private let urlRequestBuilder: IURLRequestBuilder

    // MARK: - Init
    init(urlRequestBuilder: IURLRequestBuilder = URLRequestBuilder()) {
        self.urlRequestBuilder = urlRequestBuilder
    }

    // MARK: - INetworkClient
    func getData<Request>(from request: Request) async -> Result<Request.Response, NetworkError> where Request : NetworkRequest {
        switch urlRequestBuilder.build(request: request) {
        // success - send request and get response
        case let .success(urlRequest):
            do {
                // leaved response in case of broken network error
                let (data, response) = try await urlSession.data(for: urlRequest)

                return decodeData(request: request, from: data)
            } catch {
                // or return network error
                switch (error as? URLError)?.code {
                case .some(.notConnectedToInternet):
                    return .failure(.noInternetConnection)
                case .some(.timedOut):
                    return .failure(.timeout)
                default:
                    return .failure(.networkError)
                }
            }

        // failure - send request build failure
        case let .failure(error):
            return .failure(error)
        }
    }

    // MARK: - Methods
    // decode data or return parsing error
    private func decodeData<Request>(
        request: Request,
        from data: Data
    ) -> Result<Request.Response, NetworkError> where Request : NetworkRequest {
        if let decoded = try? JSONDecoder().decode(
            Request.Response.self,
            from: data
        ) {
            return .success(decoded)
        }

        return .failure(.parsingFailure)
    }

}

