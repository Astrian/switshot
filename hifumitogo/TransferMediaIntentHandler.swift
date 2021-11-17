//
//  TransferMediaIntentHandler.swift
//  hifumitogo
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Foundation
import Intents

class TransferMediaIntentHandler: NSObject, TransferMediaIntentHandling {
  func handle(intent: TransferMediaIntent, completion: @escaping (TransferMediaIntentResponse) -> Void) {
    print("Intent triggered")
    let response = TransferMediaIntentResponse(code: .success, userActivity: nil)
    response.result = "hello world"
    completion(response)
  }
}
