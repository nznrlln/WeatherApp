//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

@MainActor protocol Coordinator: AnyObject {
    // coordinator needs a navController to control
    var navigationController: UINavigationController { get set }

    // coordinator needs a starting screen which he will push onto navController
    func start()
}
