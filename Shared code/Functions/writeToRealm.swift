//
//  writeToRealm.swift
//  star
//
//  Created by Astrian Zheng on 2021/12/1.
//

import Foundation
import RealmSwift

func writeToRealm(mediaList: [TransferedMedia]) {
  let path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  let config = Realm.Configuration(fileURL: URL(string: "\(String(describing: path))/database.realm")!)
  Realm.Configuration.defaultConfiguration = config
  let realm = try! Realm()
  let log = TransferLog()
  for i in mediaList {
    try! realm.write {
      realm.add(i)
    }
    log.media.append(i)
  }
  try! realm.write {
    realm.add(log)
  }
}
