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

func getAllFileName() -> [String]{
  let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
  let manager = FileManager.default
  let fileUrl = documentPath as String
  let subPaths = manager.subpaths(atPath: fileUrl)
  let array = subPaths?.filter({$0 != ".DS_Store"})
  return array!
}
