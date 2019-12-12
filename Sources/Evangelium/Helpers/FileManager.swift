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
                
                if readings.data.count == 4 {
                    let swiftyReadings = SwiftyReading(
                        firstReading: readings.data[0],
                        psalm: readings.data[1],
                        secondReading: readings.data[2],
                        gospel: readings.data[3],
                        date: readings.date ?? "Invalid Date"
                    )
                    
                    let encondedData = try encoder.encode(swiftyReadings)
                    try file.write(encondedData)
                } else {
                    let swiftyReadings = SwiftyReading(
                        firstReading: readings.data[0],
                        psalm: readings.data[1],
                        gospel: readings.data[2],
                        date: readings.date ?? "Invalid Date"
                    )
                    
                    let encondedData = try encoder.encode(swiftyReadings)
                    try file.write(encondedData)
                }
                
                seal.fulfill(())
            } catch {
                seal.reject(error)
                print("Error while trying to write data: \(error.localizedDescription)")
            }
        }
    }
}
