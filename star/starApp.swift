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
  @Environment(\.scenePhase) var phase
  
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environment(\.realmConfiguration, Realm.Configuration(fileURL: URL(string: "\(String(describing: path))/database.realm"), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil))
    }
    .onChange(of: phase) { newPhase in
      switch newPhase {
      case .active:
        print("App in active")
      case .inactive:
        // inactive
        print("App is inactive")
      case .background:
        print("App in Background")
        addQuickActions()
      @unknown default:
        print("default")
      }
    }
  }
  
  func addQuickActions() {
    UIApplication.shared.shortcutItems = [
      UIApplicationShortcutItem(type: "Scanner", localizedTitle: NSLocalizedString("QuickAction_ScanQRCode", comment: ""))
    ]
  }
}
