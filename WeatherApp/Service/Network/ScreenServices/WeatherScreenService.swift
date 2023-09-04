//
//  File.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 01.09.2023.
//

import Foundation

protocol IWeatherScreenService {
    func getWeather(lon: String,lat: String) async -> Result<CityWeatherModel, NetworkError>

}

final class WeatherScreenService: IWeatherScreenService {
    // MARK: - Dependencies
    private let networkClient: INetworkClient

    // MARK: - Init
    init(networkClient: INetworkClient) {
        self.networkClient = networkClient
    }

    // MARK: - IWeatherScreenService
    func getWeather(lon: String,lat: String) async -> Result<CityWeatherModel, NetworkError> {
        var cityWeather = CityWeatherModel()

        switch await getCurrentWeather(lon: lon, lat: lat) {
        case .success(let data):
            cityWeather.currentWeather = data
        case .failure(let error):
            return .failure(error)
        }

        switch await getForecast24hWeather(lon: lon, lat: lat) {
        case .success(let data):
            cityWeather.forecast24h = data
        case .failure(let error):
            return .failure(error)
        }

        switch await getForecast16dWeather(lon: lon, lat: lat) {
        case .success(let data):
            cityWeather.forecast16d = data
        case .failure(let error):
            return .failure(error)
        }

        return .success(cityWeather)
    }

    private func getCurrentWeather(lon: String, lat: String) async -> Result<CurrentWeatherModel, NetworkError> {
        let result = await networkClient.getData(from: CurrentWeatherRequest(lon: lon, lat: lat))

        switch result {
        case .success(let response):
            guard let data = response.data.first else { return .failure(.parsingFailure) }
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }

    private func getForecast24hWeather(lon: String, lat: String) async -> Result<[WeatherForecast3hModel], NetworkError> {
        let result = await networkClient.getData(from: Forecast5d3hRequest(lon: lon, lat: lat))

        switch result {
        case .success(let response):
            return .success(response.data)
        case .failure(let error):
            return .failure(error)
        }
    }

    private func getForecast16dWeather(lon: String, lat: String) async -> Result<[WeatherForecast1dModel], NetworkError> {
        let result = await networkClient.getData(from: Forecast16dRequest(lon: lon, lat: lat))

        switch result {
        case .success(let response):
            return .success(response.data)
        case .failure(let error):
            return .failure(error)
        }
    }
}
