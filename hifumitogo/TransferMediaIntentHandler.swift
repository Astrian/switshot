//
//  TransferMediaIntentHandler.swift
//  hifumitogo
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Foundation
import Intents

class TransferMediaIntentHandler: NSObject, TransferMediaIntentHandling {
  func handle(intent: TransferMediaIntent) async -> TransferMediaIntentResponse {
    do {
      let transferResult = try await transfer(saveCopy: intent.saveToLibrary as? Bool)
      let result = TransferMediaIntentResponse(code: .success, userActivity: nil)
      result.media = [INFile]()
      let log = TransferLog()
      var i = 0
      for (uuid, data) in transferResult.data {
        result.media?.append(INFile(data: data, filename: "\(uuid.uuidString).\(transferResult.mediaType == "photo" ? "jpg" : "mp4")", typeIdentifier: nil))
        let media = TransferedMedia()
        media.code = i
        media.id = uuid
        media.type = transferResult.mediaType
        log.media.append(media)
        i += 1
      }
      writeToRealm(log: log)
      result.consoleName = transferResult.consoleName
      return result
    } catch TransferringError.cannotConnectToConsole {
      return TransferMediaIntentResponse(code: .connectionError, userActivity: nil)
    } catch TransferringError.dataNotSupported {
      return TransferMediaIntentResponse(code: .dataNotSupported, userActivity: nil)
    } catch TransferringError.missingData {
      return TransferMediaIntentResponse(code: .missingData, userActivity: nil)
    } catch {
      return TransferMediaIntentResponse(code: .failure, userActivity: nil)
    }
  }
  
  func resolveSaveToLibrary(for intent: TransferMediaIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
    completion(INBooleanResolutionResult.success(with: (intent.saveToLibrary == 1)))
  }
}
