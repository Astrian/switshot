//
//  Files.swift
//  Files
//
//  Created by Astrian Zheng on 2021/9/10.
//

import Foundation

func getAppGroupSpacePath() -> String {
  return (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
}

func createFolderIfNotExisits(folderPath : String) -> Bool {
  let documentPath = getAppGroupSpacePath()
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
  let manager = FileManager.default
  let documentPath = getAppGroupSpacePath()
  let fileUrl = documentPath as String
  let subPaths = manager.subpaths(atPath: fileUrl)
  let array = subPaths?.filter({$0 != ".DS_Store"})
  return array!
}

func deleteFile(fileName: String) -> Bool {
  var success = false
  let documentPath = getAppGroupSpacePath()
  let manager = FileManager.default
  let fileUrl = documentPath as String + "/"
  let subPaths = manager.subpaths(atPath: fileUrl)
  let removePath = fileUrl + "/" + fileName
  for fileStr in subPaths!{
    if fileName == fileStr {
      try! manager.removeItem(atPath: removePath)
      success = true
    }
  }
  return success
}
