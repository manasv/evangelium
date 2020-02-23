//
//  CustomError.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 12/10/19.
//

import Foundation

enum CustomError: String, Error {
    case urlBuildError = "Error while building the URL"
    case invalidDate = "Invalid or non existing date"
    case invalidReadings = "Invalid or not existing readings, check API response."
}
