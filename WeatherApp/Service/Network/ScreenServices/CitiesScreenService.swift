//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

protocol ICitiesScreenService {
//    func getAds() async -> Result<AdsModel, NetworkError>
    func getCity(_ name: String) async -> Result<CityModel, NetworkError>
}

final class CitiesScreenService: ICitiesScreenService {
    // MARK: - Dependencies
    private let networkClient: INetworkClient
    private let geoDecoder: IGeoDecoder

    // MARK: - Init
    init(
        networkClient: INetworkClient,
        geoDecoder: IGeoDecoder
    ) {
        self.networkClient = networkClient
        self.geoDecoder = geoDecoder
    }

    // MARK: - ICitiesScreenService

    func getCity(_ name: String) async -> Result<CityModel, NetworkError> {
        switch await networkClient.getData(from: GeoRequest(locationName: name)) {
        case .success(let response):
            guard let city = await geoDecoder.convertToCity(response) else { return .failure(.parsingFailure)}
            return .success(city)
        case .failure(let error):
            return .failure(error)
        }
    }

}
