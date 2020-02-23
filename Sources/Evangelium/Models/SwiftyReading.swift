//
//  SwiftyReading.swift
//  Files
//
//  Created by Manuel Sánchez on 9/12/19.
//

import Foundation

struct SwiftyReading: Codable {
    let firstReading: Reading?
    let psalm: Reading?
    let secondReading: Reading?
    let gospel: Reading?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case firstReading = "first_reading"
        case secondReading = "second_reading"
        case psalm, gospel, date
    }
}
