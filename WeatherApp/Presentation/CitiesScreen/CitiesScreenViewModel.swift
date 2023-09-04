//
//  CitiesScreenViewModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation
import RxSwift
import RxRelay

protocol ICitiesScreenViewModel {
    var citiesList: BehaviorRelay<[CityModel]> { get }
    var alert: PublishRelay<AlertModel> { get }

    func viewDidLoad()
    func addCityButtonTap(name: String)
    func didSelectItem(index: Int)
}

final class CitiesScreenViewModel: ICitiesScreenViewModel {

    // MARK: - Properties
    let userDefaults = UserDefaultsService.shared

    weak var coordinator: AppCoodinator?

    let citiesList = BehaviorRelay<[CityModel]>(value: [])

    let alert = PublishRelay<AlertModel>()


    // MARK: - Dependencies
    private let service: ICitiesScreenService

    // MARK: - Init
    init(service: ICitiesScreenService) {
        self.service = service
    }

    func viewDidLoad() {
        getCitiesList()
    }

    func addCityButtonTap(name: String) {
        addCity(name)
    }

    func didSelectItem(index: Int) {
        let city = citiesList.value[index]
        userDefaults.currentCity = city
    }


    private func setupView() {
        getCitiesList()
    }

    private func getCitiesList() {
        let set = userDefaults.cities
        let array = Array(set)
        let sorted = array.sorted(by: {$0.city < $1.city})
        citiesList.accept(sorted)
    }

    private func addCity(_ name: String) {
        Task {
            switch await service.getCity(name) {
            case .success(let city):
                userDefaults.cities.insert(city)
            case .failure(let error):
                let alertAction = AlertActionModel(title: "Close", style: .cancel)
                let errorAlert = AlertModel(
                    title: "Error",
                    message: error.message,
                    prefferedStyle: .alert,
                    actionModels: [alertAction]
                )
                alert.accept(errorAlert)
            }

            getCitiesList()
        }
    }


}
