//
//  DateManager.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/12/19.
//

import Foundation

enum DateFormatterError: String, Error {
    case incorrectFormat = "The provided date format is wrong."
}

struct DateManager {
    private(set) var date = Date()
    
    mutating func next() {
        if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self.date) {
            self.date = nextDate
        }
    }
    
    mutating func reset() {
        self.date = Date()
    }
}

extension DateManager {
    func formattedDate() throws -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        
        if let dateToFormat = formatter.date(from: self.date.description) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: dateToFormat)
        } else {
            throw DateFormatterError.incorrectFormat
        }
    }
}

// Construct a date from an yyyy-MM-dd Strings
extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
