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

        switch model.type {
        case .message:
            let closeAction = UIAlertAction(title: "Отмена", style: .cancel)

        case .textField:
            if let placeholder = model.textFieldPlaceholder  {
                controller.addTextField { textField in
                    textField.placeholder = placeholder
                }
            }
        }

        model.actionModels.forEach({
            controller.addAction(UIAlertAction(
                title: $0.title,
                style: $0.style,
                handler: $0.handler
            ))
        })

        return controller
    }

//    static func buildAlertController(for model: AlertModel) -> UIAlertController {
//        let controller = UIAlertController(
//            title: model.title,
//            message: model.message,
//            preferredStyle: model.prefferedStyle
//        )
//
////        if let placeholder = model.textFieldPlaceholder  {
////            controller.addTextField { textField in
////                textField.placeholder = placeholder
////            }
////        }
//
//        model.actionModels.forEach({
//            controller.addAction(UIAlertAction(
//                title: $0.title,
//                style: $0.style,
//                handler: $0.handler
//            ))
//        })
//
//        return controller
//    }

//    static func buildAddCityAlertController(
//        for model: AlertModel,
//        completion: @escaping ((String) -> Void)
//    ) -> UIAlertController {
//        let controller = UIAlertController(
//            title: model.title,
//            message: model.message,
//            preferredStyle: model.prefferedStyle
//        )
//
//        
//
//        
//    }
}
