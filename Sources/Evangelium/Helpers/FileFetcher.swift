//
//  FileFetcher.swift
//
//  Created by Manuel Sánchez on 12/10/19.
//

import Foundation
import PromiseKit

protocol FileFetcherProtocol {
    func download(from promises: [ReadingPromise]) -> Promise<Void>
}

class FileFetcher: FileFetcherProtocol {
    var dateManager: DateManager
    let requester: ReadingRequester
    let fileManager: FileManager
    
    init(dateManager: DateManager, requester: ReadingRequester, fileManager: FileManager) {
        self.dateManager = dateManager
        self.requester = requester
        self.fileManager = fileManager
    }
    
    func download(from readingPromises: [ReadingPromise]) -> Promise<Void> {
        let promises = readingPromises.map { readingPromise in
            readingPromise.promise.then { readingData -> Promise<Void> in
                guard let date = readingData.date else {
                    throw PMKError.badInput
                }
                return self.fileManager.write(data: readingData,
                                               languageFolder: readingPromise.language, filename: date)
            }
        }
        
        return when(fulfilled: promises)
    }
}
