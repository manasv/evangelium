//
//  ReadingRequester.swift
//  Evangelium
//
//  Created by Manuel Sánchez on 9/8/19.
//

import Foundation
import PromiseKit

typealias ReadingResult = (Swift.Result<ReadingsData, Error>) -> Void

public struct ReadingRequester {
    func fetch(for language: String, in date: String) -> Promise<ReadingsData> {
        return Promise { seal in
            let decoder = JSONDecoder()
            let path = "/\(language)/days/\(date)/readings"
            
            guard let readingsURL = URL(string: "\(Constants.baseURL)\(path)") else {
                return
            }
            
            print("Fetching \(readingsURL)")
            
            URLSession.shared.dataTask(with: readingsURL) { data, _, error in
                if let data = data,
                    var result = try? decoder.decode(ReadingsData.self, from: data) {
                    result.date = date
                    seal.fulfill(result)
                } else if let error = error {
                    seal.reject(error)
                }
            }.resume()
        }
    }
}
