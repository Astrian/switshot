//
//  TransferMediaIntentHandler.swift
//  hifumitogo
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Foundation
import Intents
import Alamofire

class TransferMediaIntentHandler: NSObject, TransferMediaIntentHandling {
  func resolveSaveToLibrary(for intent: TransferMediaIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
    completion(INBooleanResolutionResult.success(with: (intent.saveToLibrary == 1)))
  }
  
  func handle(intent: TransferMediaIntent, completion: @escaping (TransferMediaIntentResponse) -> Void) {
    AF.request("http://192.168.0.1/data.json").responseJSON() { res in
      switch res.result {
        case .success(let json):
          Task {
            let consoleName = (json as AnyObject).value(forKey: "ConsoleName")! as! String
            let files = (json as AnyObject).value(forKey: "FileNames")! as! [String]
            var filesRaw = [INFile]()
            for media in files {
              if let url = URL(string: "http://192.168.0.1/img/\(media)") {
                let (data, _) = try await URLSession.shared.data(from: url)
                filesRaw.append(INFile(data: data, filename: media, typeIdentifier: nil))
                importer(name: media, data: data, saveCopy: (intent.saveToLibrary == 1))
              }
            }
            // connected = 1
            let response = TransferMediaIntentResponse(code: .success, userActivity: nil)
            response.consoleName = consoleName
            response.media = filesRaw
            completion(response)
          }
      case .failure(_):
          //debug("error:\(error)")
          //connected = -1
          let response = TransferMediaIntentResponse(code: .connectionError, userActivity: nil)
          completion(response)
          break
      }
    }
  }
}
