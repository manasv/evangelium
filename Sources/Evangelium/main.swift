import Foundation
import Dispatch

let requester = ReadingRequester()
let fileManager = FileManager()

let dateManager = DateManager()

let dispatchGroup = DispatchGroup()

let languages =  Language.allCases

DispatchQueue.concurrentPerform(iterations: languages.count) { index in
    let fileFetcher = FileFetcher(dateManager: dateManager,
                                  requester: requester,
                                  fileManager: fileManager)
    
    dispatchGroup.enter()
    fileFetcher.download(for: languages[index]) {
        dispatchGroup.leave()
    }
}

dispatchGroup.notify(queue: .main) {
    exit(0)
}

RunLoop.main.run()
