//
//  Language.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/12/19.
//

import Foundation

enum Language: String, CaseIterable {
    case spanish = "sp"
    case english = "am"
    case italian = "it"
    case french = "fr"
    case german = "de"
    case korean = "kr"
    case portuguese = "pt"
    
    var folderName: String {
        switch self {
        case .spanish:
            return "es"
        case .english:
            return "en"
        default:
            return rawValue
        }
    }
}
