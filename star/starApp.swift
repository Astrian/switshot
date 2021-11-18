//
//  starApp.swift
//  star
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI

@main
struct starApp: App {
  var body: some Scene {
    WindowGroup {
      TabView {
        ConnectionView()
          .tabItem {
            Label("Tabs_Connection", systemImage: "link.circle.fill")
          }
        MediaCollectionView()
          .tabItem {
            Label("Tabs_Album", systemImage: "photo.fill.on.rectangle.fill")
          }
      }
    }
  }
}
