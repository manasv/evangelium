//
//  FileManager.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/11/19.
//

import Foundation
import Files

struct FileManager {
    let encoder = JSONEncoder()
    
    func write<T: Codable>(data: T, languageFolder: Language, filename: String) {
        do {
            let folderName = languageFolder.folderName
            
            let rootFolder = Folder(storage: Folder.current.storage)
            let dataFolder = try rootFolder.createSubfolder(at: "data")
            let langFolder = try dataFolder.createSubfolder(at: folderName)
            
            let file = try langFolder.createFile(named: "\(filename).json")
            
            guard let readings = data as? ReadingsData else {
                return
            }
            
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
        } catch {
            print("Error while trying to write data: \(error.localizedDescription)")
        }
    }
}
