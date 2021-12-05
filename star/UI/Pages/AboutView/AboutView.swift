//
//  AboutView.swift
//  AboutView
//
//  Created by Astrian Zheng on 2021/9/11.
//
import SwiftUI

struct AboutView: View {
  @State private var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  @Binding var presented: Bool
  
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
          Link("AboutView_SystemSettings", destination: URL(string: UIApplication.openSettingsURLString)!)
          Link("AboutView_Repo", destination: URL(string: "https://github.com/Astrian/switshot")!)
        }
      }
      .navigationTitle("AboutView_Title")
      
    }
  }
}
