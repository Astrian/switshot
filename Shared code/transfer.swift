//
//  importer.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Foundation
import UIKit

@available(iOS 15.0, *)
func transfer(saveCopy: Bool?) async throws -> TransferResult {
  guard let consoleUrl = URL(string: "http://192.168.0.1/data.json") else { throw TransferringError.missingData }
  let request = URLRequest(url: consoleUrl)
  let (data, response) = try await URLSession.shared.data(for: request)
  guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw TransferringError.cannotConnectToConsole }
  let res = try JSONDecoder().decode(ConsoleResponse.self, from: data)
  var files = [UUID: Data]()
  for item in res.FileNames {
    guard let fileUrl = URL(string: "http://192.168.0.1/img/\(item)") else { continue }
    let fileRequest = URLRequest(url: fileUrl)
    let (fileData, fileResponse) = try await URLSession.shared.data(for: fileRequest)
    guard (fileResponse as? HTTPURLResponse)?.statusCode == 200 else { continue }
    let fileUuid = UUID()
    files[fileUuid] = fileData
    let manager = FileManager.default
    let path = (manager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
    let fileName = (fileUuid.uuidString) + "." + String(item.split(separator: ".")[1])
    manager.createFile(atPath: "\(String(describing: path))/\(fileName)", contents: data, attributes: nil)
    if (saveCopy ?? false) { UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil) }
  }
  let transferResult = TransferResult(consoleName: res.ConsoleName, data: files, mediaType: res.FileType)
  return transferResult
}

struct TransferResult {
  var consoleName: String
  var data: [UUID: Data]
  var mediaType: String
}

enum TransferringError: Error {
  case missingData
  case cannotConnectToConsole
  case dataNotSupported
}

struct ConsoleResponse: Codable {
  var FileType: String
  var DownloadMes: String?
  var PhotoHelpMes: String?
  var MovieHelpMes: String?
  var ConsoleName: String
  var FileNames: [String]
}
