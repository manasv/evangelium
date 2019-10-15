//
//  ReadingRequester.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/8/19.
//

import Foundation

typealias ReadingResult = (Result<ReadingsData, Error>) -> Void

public struct ReadingRequester {
    
    func fecth(for language: String, in date: String, with completion: @escaping ReadingResult) {
        let decoder = JSONDecoder()
        
        let path = "/\(language)/days/\(date)/readings"
        
        guard let readingsURL = URL(string: "\(Constants.baseURL)\(path)") else {
            return
        }
        
        print("Fetching \(readingsURL)")

        // Sending request to the server.
        let task = URLSession.shared.dataTask(with: readingsURL) { [date] data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                DispatchQueue.main.async {
                    do {
                        var model = try decoder.decode(ReadingsData.self, from: data)
                        model.date = date
                        completion(.success(model))
                    } catch {
                        print("Error ocurred while decoding: \(error.localizedDescription)")
                    }
                }
            } else {
                guard let error = error else {
                    return
                }
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
