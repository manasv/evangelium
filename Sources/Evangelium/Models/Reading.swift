//
//  Reading.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/7/19.
//

import Foundation

struct ReadingsData: Codable {
    var date: String?
    let data: [Reading]
}

struct Reading: Codable {
    let title: String
    let referenceDisplayed: String
    let readingText: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case referenceDisplayed = "reference_displayed"
        case readingText = "text"
        case title, type
    }
}
