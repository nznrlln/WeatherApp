//
//  AlertHelper.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

final class AlertHelper {

    func addCityAlert(completion: @escaping ((String) -> Void)) -> UIAlertController {
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
    
    static func showErrorMessageAlert(message: String, completion: @escaping (() -> Void))  -> UIAlertController {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { action in
            completion()
        }
        let closeAction = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alertController.addAction(retryAction)
        alertController.addAction(closeAction)
        
        return alertController
    }
    
}


