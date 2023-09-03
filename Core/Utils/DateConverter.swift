//
//  DateConverter.swift
//  WeatherApp
//
//  Created by Нияз Нуруллин on 31.08.2023.
//

import Foundation

protocol DateConverterProtocol {
    func getConvertedDate(
        initialFormat: String,
        _ date: String,
        finalFormat: String
    ) -> String
}

final class DateConverter: DateConverterProtocol {
    
    // MARK: - Singleton & properties
    static let shared = DateConverter()
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - Init
    private init() {
        self.dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    // MARK: - DateConverterProtocol
    func getConvertedDate(
        initialFormat: String,
        _ date: String,
        finalFormat: String
    ) -> String {
        dateFormatter.dateFormat = initialFormat
        guard let date = dateFormatter.date(from: date) else { return "no date" }
        
        dateFormatter.dateFormat = finalFormat
        let text = dateFormatter.string(from: date)
        
        return text
    }
    
}
