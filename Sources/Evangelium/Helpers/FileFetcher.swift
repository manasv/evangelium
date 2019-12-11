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
    
    func download(from promises: [ReadingPromise]) -> Promise<Void> {
        return Promise { seal in
            
            for readingPromise in promises {
                readingPromise.promise.get { reading in
                    if let date = reading.date {
                       self.fileManager.write(data: reading, languageFolder: readingPromise.language, filename: date)
                    }
                }.done { _ in
                    seal.fulfill(Void())
                }.catch { error in
                    seal.reject(error)
                }
            }
        }
    }
}
