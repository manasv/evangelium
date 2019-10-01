import Foundation

let requester = ReadingRequester()
let fileManager = FileManager()

var dateManager = DateManager()

for language in Language.allCases {
    for _ in 0 ..< 7 {
        let readingDate = try dateManager.formattedDate()
        
        requester.fecth(for: language.rawValue, in: readingDate) { result in
            switch result {
            case .success(let response):
                fileManager.write(data: response, languageFolder: language, filename: response.date ?? "")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        dateManager.next()
    }
    dateManager.reset()
}

RunLoop.main.run(until: Date().addingTimeInterval(30))
