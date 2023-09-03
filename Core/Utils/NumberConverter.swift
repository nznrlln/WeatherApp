//
//  NumberConverter.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

protocol NumberConverterProtocol {
    func getConvertedPrice(_ price: String) -> String
}

final class NumberConverter: NumberConverterProtocol {
    
    // MARK: - Singleton & properties
    static let shared = NumberConverter()
    
    private let numberFormatter = NumberFormatter()
    
    // MARK: - Init
    private init() {
        numberFormatter.groupingSeparator = " "
        numberFormatter.groupingSize = 3
    }
    
    // MARK: - NumberConverterProtocol
    func getConvertedPrice(_ price: String) -> String {
        // remove currency and whitespace
        let str = String(price.dropLast())
        let trimmed = str.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let double = Double(trimmed) else { return "invalid price" }
        numberFormatter.numberStyle = .decimal
        // add space each 3 digits
        return (numberFormatter.string(for: double) ?? "") + " ₽"
    }
}
