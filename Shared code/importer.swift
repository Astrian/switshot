//
//  importer.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/17.
//

import Foundation
import UIKit

func importer(name: String, data: Data, saveCopy: Bool) {
  let manager = FileManager.default
  let path = (manager.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  let uuid = UUID()
  let fileName = (uuid.uuidString) + "." + String(name.split(separator: ".")[1])
  manager.createFile(atPath: "\(String(describing: path))/\(fileName)", contents: data, attributes: nil)
  if saveCopy {
    UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
  }
}
