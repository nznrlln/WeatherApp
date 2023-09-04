//
//  BackgroundHelper.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 04.09.2023.
//

import Foundation

final class BackgroundHelper {

    static func getBackgroundName(code: Int) -> String {
        if (0...299).contains(code) {
            return "ThunderBackground"
        }
        if (300...699).contains(code) {
            return "RainBackground"
        }
        if (700...799).contains(code) || code == 804 {
            return "CloudsBackground"
        }
        if (800...803).contains(code) {
            return "SunBackground"
        }

        return "DefaultBackground"
    }
}
