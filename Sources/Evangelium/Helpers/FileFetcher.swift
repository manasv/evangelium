//
//  File.swift
//  
//
//  Created by Gustavo Campos on 10/1/19.
//

import Foundation
import PromiseKit

class FileFetcher {
    var dateManager: DateManager
    let requester: ReadingRequester
    let fileManager: FileManager
    
    init(dateManager: DateManager, requester: ReadingRequester, fileManager: FileManager) {
        self.dateManager = dateManager
        self.requester = requester
        self.fileManager = fileManager
    }
    
    func download(for language: Language) {
        let readingDate = try? dateManager.formattedDate()
        
        for _ in 0 ..< 7 {
            requester.fetch(for: language.rawValue, in: readingDate ?? "").done { reading in
                self.fileManager.write(data: reading, languageFolder: language, filename: reading.date ?? "")
            }.catch { error in
                print(error.localizedDescription)
            }
            self.dateManager.next()
        }
        
        self.dateManager.reset()
    }
}
