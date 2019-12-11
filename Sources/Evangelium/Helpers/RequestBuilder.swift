//
//  RequestBuilder.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 12/10/19.
//

import Foundation
import PromiseKit

protocol RequestBuilderProtocol {
    func createPromises(for language: Language) throws -> [ReadingPromise]
}

class ReadingsRequestBuilder: RequestBuilderProtocol {
    var dateManager: DateManager
    var requester: ReadingRequester
    
    init(dateManager: DateManager, requester: ReadingRequester) {
        self.dateManager = dateManager
        self.requester = requester
    }
    
    func createPromises(for language: Language) throws -> [ReadingPromise] {
        do {
            var promises = [ReadingPromise]()
            let readingDate = try dateManager.formattedDate()
            
            for _ in 0 ..< 7 {
                let promise = requester.fetch(for: language.rawValue, in: readingDate)
                let readingPromise = ReadingPromise(promise: promise, language: language)
                
                promises.append(readingPromise)
                self.dateManager.next()
            }
            
            self.dateManager.reset()
            
            return promises
        } catch {
           throw error
        }
    }
}
