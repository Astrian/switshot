//
//  Files.swift
//  Files
//
//  Created by Astrian Zheng on 2021/9/10.
//

import Foundation

func createFolderIfNotExisits(folderPath : String) -> Bool {
  let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
  let fileManager = FileManager.default
  let filePath = documentPath as String + "/" + folderPath
  let exist = fileManager.fileExists(atPath: filePath)
  if !exist {
    do {
      try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
    } catch {
      return false
    }
  }
  return true
}
