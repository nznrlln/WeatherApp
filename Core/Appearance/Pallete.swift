//
//  Pallete.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

enum Palette {
    static let transparentAlpha: CGFloat = 0.9

    static let mainBackground = UIColor.systemBackground
    static let secondaryBackground = UIColor.white.withAlphaComponent(0.6)
    static let clearBackground = UIColor.clear

    static let blackAndWhite = UIColor.createColor(lightMode: .black, darkMode: .white)
    static let secondaryText = UIColor(named: "SecondaryTextColor") ?? .systemGray5
}
