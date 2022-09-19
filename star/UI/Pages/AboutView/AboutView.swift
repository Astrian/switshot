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
        
        Section {
          Link("AboutView_SystemSettings", destination: URL(string: UIApplication.openSettingsURLString)!)
        }
        
        Section {
          Link("AboutView_HelpCenter", destination: URL(string: NSLocalizedString("AboutView_HelpCenter_Link", comment: ""))!)
          Link("AboutView_Updates", destination: URL(string: "https://updates.switshot.app/")!)
          Link("AboutView_Weibo", destination: URL(string: "https://weibo.com/n/Narixtas")!)
          Link("AboutView_Jike", destination: URL(string: "https://okjk.co/mNUu59")!)
        }
        
        Section(header: Text("AboutView_Comm")) {
          Link("AboutView_Discord", destination: URL(string: "https://discord.gg/zeT2nnGvAA")!)
          Link("AboutView_QQ", destination: URL(string: "https://jq.qq.com/?_wv=1027&k=VFMbQrFe")!)
        }
        
        Section(header: Text("AboutView_Appreciation")) {
          VStack (alignment: .leading){
            Text("AboutView_Appreciation_Contributor_EanaHufwe").bold()
            Text("AboutView_Appreciation_ContibuteTitle_EanaHufwe").font(.callout)
            Link("AboutView_Appreciation_Contibutor_Website", destination: URL(string: "https://1a23.com/")!).font(.callout)
          }
        }
        
        Section (footer: Text("AboutView_OpenSource")) {
          Link("AboutView_AppStore", destination: URL(string: "https://apps.apple.com/us/app/switshot/id1585470023?action=write-review")!)
          Link("AboutView_Repo", destination: URL(string: "https://github.com/Astrian/switshot")!)
        }
      }
      .navigationTitle("AboutView_Title")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            presented = false
          } label: {
            Text("AboutView_Dismiss")
          }
        }
      }
    }
  }
}
