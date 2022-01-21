//
//  starApp.swift
//  star
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import RealmSwift
import Foundation

var shortcutItemToProcess: UIApplicationShortcutItem?

@main
struct starApp: SwiftUI.App {
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  @State var showQRScanner = false
  @Environment(\.scenePhase) var phase
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      HomeView(showQRScanner: $showQRScanner)
        .environment(\.realmConfiguration, Realm.Configuration(fileURL: URL(string: "\(String(describing: path))/database.realm"), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil))
    }
    .onChange(of: phase) { newPhase in
      switch newPhase {
      case .active:
        print("App in active")
        guard let shortcutItem = shortcutItemToProcess?.type else {
          return
        }
        switch (shortcutItem){
        case "Scanner":
          showQRScanner = true
        default:
          print("do noting")
        }
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
      UIApplicationShortcutItem(type: "Scanner", localizedTitle: NSLocalizedString("QuickAction_ScanQRCode", comment: ""), localizedSubtitle: "", icon: UIApplicationShortcutIcon(systemImageName: "qrcode.viewfinder"))
    ]
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    if let shortcutItem = options.shortcutItem {
      shortcutItemToProcess = shortcutItem
    }
      
    let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
    sceneConfiguration.delegateClass = CustomSceneDelegate.self
    
    return sceneConfiguration
  }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
  func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    shortcutItemToProcess = shortcutItem
  }
}
