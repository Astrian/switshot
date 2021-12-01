//
//  writeToRealm.swift
//  star
//
//  Created by Astrian Zheng on 2021/12/1.
//

import Foundation
import RealmSwift

func writeToRealm(log: TransferLog) {
  let path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  let config = Realm.Configuration(fileURL: URL(string: "\(String(describing: path))/database.realm")!)
  Realm.Configuration.defaultConfiguration = config
  let realm = try! Realm()
  try! realm.write {
    for i in log.media {
      realm.add(i)
    }
    realm.add(log)
  }
}
