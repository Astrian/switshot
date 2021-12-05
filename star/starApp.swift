//
//  starApp.swift
//  star
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import RealmSwift
import Foundation

@main
struct starApp: SwiftUI.App {
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environment(\.realmConfiguration, Realm.Configuration(fileURL: URL(string: "\(String(describing: path))/database.realm"), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil))
    }
  }
}
