//
//  IntentHandler.swift
//  hifumitogo
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Intents

class IntentHandler: INExtension {
    
  override func handler(for intent: INIntent) -> Any {
      // This is the default implementation.  If you want different objects to handle different intents,
      // you can override this and return the handler you want for that particular intent.
    switch intent {
    case is TransferMediaIntent:
      return TransferMediaIntentHandler()
    default:
      fatalError("No handler for this intent")
    }
  }
    
}
