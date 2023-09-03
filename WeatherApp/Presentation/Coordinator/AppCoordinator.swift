//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

@MainActor final class AppCoodinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        self.navigationController.navigationBar.tintColor = Palette.blackAndWhite
    }

    // MARK: - Coordinator
    func start() {

        let service = WeatherScreenService(networkClient: NetworkClient())
        let viewModel = WeatherScreenViewModel(service: service)
        viewModel.coordinator = self

        let vc = WeatherScreenViewController(viewModel: viewModel)

        navigationController.pushViewController(vc, animated: true)
    }

}


extension AppCoodinator {
    func moveToCitiesScreen() {
        let vc = CitiesScreenViewController()

        let service = CitiesScreenService(
            networkClient: NetworkClient(),
            geoDecoder: GeoDecoder()
        )
        let viewModel = CitiesScreenViewModel(service: service)

        vc.viewModel = viewModel

        navigationController.pushViewController(vc, animated: true)
    }
}
