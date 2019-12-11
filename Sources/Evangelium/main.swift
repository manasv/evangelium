import Foundation
import PromiseKit

let requester = ReadingRequester()
let fileManager = FileManager()
let dateManager = DateManager()

let languages = Language.allCases

let fileFetcher = FileFetcher(dateManager: dateManager, requester: requester, fileManager: fileManager)
let requestBuilder = ReadingsRequestBuilder(dateManager: dateManager, requester: requester)
var readingPromises = [ReadingPromise]()

for language in languages {
    do {
        readingPromises += try requestBuilder.createPromises(for: language)
    } catch {
        print(error.localizedDescription)
    }
}

fileFetcher.download(from: readingPromises).done {
    exit(0)
}.catch { error in
    print(error.localizedDescription)
}

RunLoop.main.run()
