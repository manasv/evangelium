//
//  ReadingFactory.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 2/4/20.
//

import Foundation

enum ReadingFactory {
    static func create(from todayReadings: [Reading], with date: String) throws -> SwiftyReading {
        let readings = todayReadings.filter { reading in reading.type == "reading" }
        let psalm = todayReadings.filter { reading in reading.type == "psalm" }.first
        let gospel = todayReadings.filter { reading in reading.type == "gospel" }.first
        let numberOfReadings = readings.count
        
        switch  numberOfReadings {
        case 2:
            return SwiftyReading(
                firstReading: readings.first,
                psalm: psalm,
                secondReading: readings.last,
                gospel: gospel,
                date: date
            )
        case 1:
            if readings.count == 1, todayReadings.first?.type == "reading" {
                return SwiftyReading(
                    firstReading: readings.first,
                    psalm: psalm,
                    secondReading: nil,
                    gospel: gospel,
                    date: date
                )
            } else {
                return SwiftyReading(
                    firstReading: nil,
                    psalm: psalm,
                    secondReading: readings.first,
                    gospel: gospel,
                    date: date
                )
            }
        case 0:
            return SwiftyReading(
                firstReading: nil,
                psalm: psalm,
                secondReading: nil,
                gospel: gospel,
                date: date
            )
        default:
            throw CustomError.invalidReadings
        }
    }
}
