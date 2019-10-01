//
//  File.swift
//  
//
//  Created by Gustavo Campos on 10/1/19.
//

import Foundation


class FileFetcher {
    
    private let dispatchGroup = DispatchGroup()
    
    var dateManager: DateManager
    
    let requester: ReadingRequester
    
    let fileManager: FileManager
    
    init(dateManager: DateManager,
         requester: ReadingRequester,
         fileManager: FileManager) {
        self.dateManager = dateManager
        self.requester = requester
        self.fileManager = fileManager
    }
    
    
    func download(for language: Language, completion: @escaping () -> Void) {
        DispatchQueue.concurrentPerform(iterations: 7) { _ in
            let readingDate = try? dateManager.formattedDate()
            dispatchGroup.enter()
            requester.fecth(for: language.rawValue, in: readingDate ?? "") { result in
                switch result {
                case .success(let reading):
                    fileManager.write(data: reading, languageFolder: language, filename: reading.date ?? "")
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
                self.dispatchGroup.leave()
            }
            dateManager.next()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.dateManager.reset()
            completion()
        }
    }
}
