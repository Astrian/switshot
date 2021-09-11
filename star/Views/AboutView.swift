//
//  AboutView.swift
//  AboutView
//
//  Created by Astrian Zheng on 2021/9/11.
//

import SwiftUI

struct AboutView: View {
  @State private var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  
  var body: some View {
    NavigationView {
      Form {
        HStack {
          Text("AboutView_Version")
          Spacer()
          Text(appVersion ?? "?")
            .foregroundColor(Color.gray)
        }
        
        Section (footer: Text("AboutView_OpenSource")) {
          Button(action: {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
              return
            }
            UIApplication.shared.open(settingsUrl)
          }) {
            Text("AboutView_SystemSettings")
          }
          Button(action: {
            guard let settingsUrl = URL(string: "https://github.com/Astrian/switshoot") else {
              return
            }
            UIApplication.shared.open(settingsUrl)
          }) {
            Text("AboutView_Repo")
          }
        }
      }
      .navigationTitle("AboutView_Title")
    }
  }
}
