//
//  WeatherScreenViewModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation
import RxSwift
import RxRelay

protocol IWeatherScreenViewModel {
    var currentCityName: PublishRelay<String> { get }
    var cityWeather: PublishRelay<CityWeatherModel> { get }
    var alert: PublishRelay<AlertModel> { get }

    func viewDidLoad()
    func viewWillAppear()
    func citiesButtonTap()
    func refreshButtonTap()
}

final class WeatherScreenViewModel: IWeatherScreenViewModel {
    // MARK: - Properties
    let userDefaults = UserDefaultsService.shared

    weak var coordinator: AppCoodinator?

    private var currentCity: CityModel? {
        userDefaults.currentCity
    }
    let currentCityName = PublishRelay<String>()
    let cityWeather = PublishRelay<CityWeatherModel>()

    let alert = PublishRelay<AlertModel>()


    // MARK: - Dependencies
    private let service: IWeatherScreenService

    // MARK: - Init
    init(service: IWeatherScreenService) {
        self.service = service
    }

    @MainActor func citiesButtonTap() {
        coordinator?.moveToCitiesScreen()
    }

    func refreshButtonTap() {
        getCityWeather()
    }

    func viewDidLoad() {
        setupView()
    }

    func viewWillAppear() {
        setupView()
    }

    private func setupView() {
        getCurrentCity()
        if !checkCachedWeather() {
//            getCityWeather()
        }
    }

    private func getCurrentCity() {
        guard let city = currentCity else { return }

        let name = "\(city.city), \(city.country)"
        currentCityName.accept(name)
    }

    private func checkCachedWeather() -> Bool {
        guard let city = currentCity else { return false }
        print(userDefaults.citiesWeather)
        guard let weathers = userDefaults.citiesWeather else { return false }
        guard let cached = weathers[city.uid] else { return false }
        cityWeather.accept(cached)

        return true
    }
    private func getCityWeather() {
        Task {
            guard let city = currentCity else { return }

            switch await service.getWeather(lon: city.lon,lat: city.lat) {
            case .success(let weather):
                userDefaults.citiesWeather?.updateValue(weather, forKey: city.uid)
                cityWeather.accept(weather)
            case .failure(let error):
                let alertAction = AlertActionModel(title: "Close", style: .cancel)
                let errorAlert = AlertModel(
                    title: "Error",
                    message: error.message,
                    prefferedStyle: .alert,
                    actionModels: [alertAction]
                )
                alert.accept(errorAlert)            }
        }
    }


}
