//
//  Language.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/12/19.
//

import Foundation

enum Language: String, CaseIterable {
    case sp = "sp"
    case am = "am"
    case it = "it"
    case fr = "fr"
    case de = "de"
    case kr = "kr"
    case pt = "pt"
    
    var folderName: String {
        switch self {
        case .sp:
            return "es"
        case .am:
            return "en"
        default:
            return rawValue
        }
    }
}
