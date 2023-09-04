//
//  AlertModel.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 02.09.2023.
//

import UIKit

struct AlertModel {
    var title: String?
    var message: String?
    var prefferedStyle: UIAlertController.Style
    var actionModels = [AlertActionModel]()
}

struct AlertActionModel {
    var title: String?
    var style: UIAlertAction.Style
    var handler: ((UIAlertAction) -> ())?
}

