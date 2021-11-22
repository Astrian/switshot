//
//  starApp.swift
//  star
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import RealmSwift

@main
struct starApp: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      HomeView()
        .environment(\.realmConfiguration, Realm.Configuration( /* ... */ ))
    }
  }
}
