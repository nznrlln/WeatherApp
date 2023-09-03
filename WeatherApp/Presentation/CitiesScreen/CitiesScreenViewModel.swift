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
    func addCityButtonTap()
    func didSelectItem(index: Int)
}

final class CitiesScreenViewModel: ICitiesScreenViewModel {

    // MARK: - Properties
//    @MainActor weak var view: CitiesScreenViewInput? {
//        didSet {
//            setupView()
//        }
//    }

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

    func addCityButtonTap() {
        addCity("Kazan")
//        let action = AlertActionModel(
//            title: "Добавить",
//            style: .default) { action in
//                <#code#>
//            } textFieldHandler: { <#UIAlertAction#> in
//                <#code#>
//            }



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
                debugPrint(error)
//                let errorAlert = AlertModel(type: <#T##AlertType#>, title: "Ошибка", message: error, prefferedStyle: .alert)
//                alert.accept()
            }

            getCitiesList()
        }
    }


}
