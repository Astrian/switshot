//
//  importer.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/17.
//

import UIKit

func transfer(saveCopy: Bool?) async throws -> TransferResult {
  guard let consoleUrl = URL(string: "http://192.168.0.1/data.json") else { throw TransferringError.missingData }
  let request = URLRequest(url: consoleUrl)
  let (data, response) = try await URLSession.shared.data(for: request)
  guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw TransferringError.cannotConnectToConsole }
  let res = try JSONDecoder().decode(ConsoleResponse.self, from: data)
  var files = [UUID: Data]()
  let manager = FileManager.default
  let path = (manager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  let exist = manager.fileExists(atPath: "\(path)/media")
  if !exist {
    do {
      try manager.createDirectory(atPath: "\(path)/media", withIntermediateDirectories: true, attributes: nil)
    } catch {
      return TransferResult(consoleName: "", data: [UUID: Data](), mediaType: "")
    }
  }
  var i = 0
  for item in res.FileNames {
    print("Transferring")
    print("http://192.168.0.1/img/\(item)")
    guard let fileUrl = URL(string: "http://192.168.0.1/img/\(item)") else { continue }
    let fileRequest = URLRequest(url: fileUrl)
    let (fileData, fileResponse) = try await URLSession.shared.data(for: fileRequest)
    guard (fileResponse as? HTTPURLResponse)?.statusCode == 200 else { continue }
    let fileUuid = UUID()
    files[fileUuid] = fileData
    let fileName = (fileUuid.uuidString) + "." + String(item.split(separator: ".")[1])
    print("fileName = \(fileName)")
    manager.createFile(atPath: "\(String(describing: path))/media/\(fileName)", contents: fileData, attributes: nil)
    if (saveCopy ?? false) {
      if res.FileType == "photo" {
        UIImageWriteToSavedPhotosAlbum(UIImage(data: fileData)!, nil, nil, nil)
      } else if res.FileType == "movie" {
        saveVideo(fileUuid)
      }
    }
    i += 1
  }
  let transferResult = TransferResult(consoleName: res.ConsoleName, data: files, mediaType: res.FileType)
  return transferResult
}

enum TransferringError: Error {
  case missingData
  case cannotConnectToConsole
  case dataNotSupported
}

struct TransferResult {
  var consoleName: String
  var data: [UUID: Data]
  var mediaType: String
}

struct ConsoleResponse: Codable {
  var FileType: String
  var DownloadMes: String?
  var PhotoHelpMes: String?
  var MovieHelpMes: String?
  var ConsoleName: String
  var FileNames: [String]
}
