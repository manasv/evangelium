//
//  ReadingFactory.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 2/4/20.
//

import Foundation

struct ReadingFactory {
    static func create(from todayReadings: [Reading], with date: String) -> SwiftyReading{
        let readings = todayReadings.filter { reading in reading.type == "reading" }
        let psalm = todayReadings.filter { reading in reading.type == "psalm" }
        let gospel = todayReadings.filter { reading in reading.type == "gospel" }
        
        if readings.count == 2 {
            return SwiftyReading(
                firstReading: readings.first,
                psalm: !psalm.isEmpty ? psalm.first : nil,
                secondReading: readings.last,
                gospel: !gospel.isEmpty ? gospel.first : nil,
                date: date
            )
        } else if readings.count == 1, todayReadings.first?.type == "reading"{
            return SwiftyReading(
                firstReading: readings.first,
                psalm: !psalm.isEmpty ? psalm.first : nil,
                secondReading: nil,
                gospel: !gospel.isEmpty ? gospel.first : nil,
                date: date
            )
        } else if readings.count == 1, todayReadings.first?.type != "reading"{
            return SwiftyReading(
                firstReading: nil,
                psalm: !psalm.isEmpty ? psalm.first : nil,
                secondReading: readings.first,
                gospel: !gospel.isEmpty ? gospel.first : nil,
                date: date
            )
        } else if readings.count == 0 {
            return SwiftyReading(
                firstReading: nil,
                psalm: !psalm.isEmpty ? psalm.first : nil,
                secondReading: nil,
                gospel: !gospel.isEmpty ? gospel.first : nil,
                date: date
            )
        }
        
        return SwiftyReading(date: "Invalid")
    }
}
