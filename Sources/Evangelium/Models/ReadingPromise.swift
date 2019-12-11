//
//  ReadingPromise.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 12/10/19.
//

import Foundation
import PromiseKit

struct ReadingPromise {
    let promise: Promise<ReadingsData>
    let language: Language
}
