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
  func handle(intent: TransferMediaIntent, completion: @escaping (TransferMediaIntentResponse) -> Void) {
    AF.request("http://192.168.0.1/data.json").responseJSON() { res in
      switch res.result {
        case .success(let json):
          let consoleName = (json as AnyObject).value(forKey: "ConsoleName")! as! String
          let files = (json as AnyObject).value(forKey: "FileNames")! as! [String]
          var filesRaw = [INFile]()
          for media in files {
            AF.download("http://192.168.0.1/img/\(media)" ).responseData { response in
              if response.error == nil {
                filesRaw.append(INFile(data: response.value!, filename: media, typeIdentifier: "jpg"))
              }
            }
          }
          // connected = 1
          let response = TransferMediaIntentResponse(code: .success, userActivity: nil)
          response.consoleName = consoleName
          response.media = filesRaw
          completion(response)
          break
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
