//
//  AlertBuilder.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 02.09.2023.
//

import UIKit

final class AlertBuilder {

    static func buildAlertController(for model: AlertModel) -> UIAlertController {
        let controller = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: model.prefferedStyle
        )

        model.actionModels.forEach({
            controller.addAction(UIAlertAction(
                title: $0.title,
                style: $0.style,
                handler: $0.handler
            ))
        })

        return controller
    }

    static func buildAddCityAlert(completion: @escaping ((String) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "Добавить город", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Название города"
        }

        let createAction = UIAlertAction(title: "Добавить", style: .default) { action in
            if let cityName = alertController.textFields![0].text,
               cityName != "" {
                completion(cityName)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alertController.addAction(createAction)
        alertController.addAction(cancelAction)

        return alertController
    }

}
