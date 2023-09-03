//
//  AlertModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 02.09.2023.
//

import UIKit

enum AlertType {
    case message
    case textField
}

struct AlertModel {
    var type: AlertType
    var title: String?
    var message: String?
    var prefferedStyle: UIAlertController.Style
    var actionModels = [AlertActionModel]()

    var textFieldPlaceholder: String?
    var textFieldCompletion: ((String) -> Void)?
}

struct AlertActionModel {
    var title: String?
    var style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> ())?
    var textFieldHandler: ((UIAlertAction) -> (String))?
}

