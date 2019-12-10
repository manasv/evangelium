import Foundation
import Dispatch

let requester = ReadingRequester()
let fileManager = FileManager()
let dateManager = DateManager()

let fileFetcher = FileFetcher(dateManager: dateManager, requester: requester, fileManager: fileManager)

fileFetcher.download()

RunLoop.main.run()
