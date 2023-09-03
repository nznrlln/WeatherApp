//
//  UIView+Extention.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import UIKit

extension UIView {
    static var identifier: String {
        String(describing: self)
    }
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
