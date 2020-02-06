//
//  FileManager.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/11/19.
//

import Foundation
import Files
import PromiseKit

enum FileError: Error {
    case incorrectReadingData
}

struct FileManager {
    let encoder = JSONEncoder()
    
    func write(data readings: ReadingsData, languageFolder: Language, filename: String) -> Promise<Void> {
        return Promise { seal in
            do {
                let folderName = languageFolder.folderName
                
                let rootFolder = Folder(storage: Folder.current.storage)
                let dataFolder = try rootFolder.createSubfolder(at: "data")
                let langFolder = try dataFolder.createSubfolder(at: folderName)
                
                let file = try langFolder.createFile(named: "\(filename).json")
                
                guard let date = readings.date else {
                    seal.reject(CustomError.invalidDate)
                    return
                }
                
                let swiftyReading = ReadingFactory.create(from: readings.data, with: date)
                
                let encondedData = try encoder.encode(swiftyReading)
                try file.write(encondedData)
                
                seal.fulfill(())
            } catch {
                seal.reject(error)
                print("Error while trying to write data: \(error.localizedDescription)")
            }
        }
    }
}
