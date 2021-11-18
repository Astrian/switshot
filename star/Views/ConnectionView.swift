//
//  ConnectionView.swift
//  ConnectionView
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import SystemConfiguration
import Alamofire
import AlertToast

struct ConnectionView: View {
  @State private var connected = 0
  @State private var transfered = 0
  @State private var consoleName = ""
  @State private var files = [String]()
  @State private var showAlert = false
  @State private var alertContent = ""
  @State private var showAbout = false
  
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        if connected == 0 {
          Text("⏳")
            .font(.custom("", size: 80))
            .padding(.bottom)
          Text("ConnectionView_Connecting")
            .font(.headline)
        } else if connected == 1 {
          if transfered == 1 {
            Text("✅")
              .font(.custom("", size: 80))
              .padding(.bottom)
            Text(String(format: NSLocalizedString("ConnectionView_Transferred", comment: ""), consoleName))
              .font(.headline)
              .padding(.bottom)
            Text(String(format: NSLocalizedString("ConnectionView_Transferred_Desc", comment: ""), consoleName))
              .padding(.bottom)
              .multilineTextAlignment(.center)
            Button(action: {
              connected = 0
              transfered = 0
              files = [String]()
              req()
            }) {
              Text("ConnectionView_TransferMoreBtn")
                .padding(.horizontal, 25)
            }
            .frame(height: 50)
            .background(Color("AccentColor"))
            .foregroundColor(Color(.white))
            .cornerRadius(25)
          } else if transfered == 0{
            VStack {
              Text("🪄")
                .font(.custom("", size: 80))
                .padding(.bottom)
              Text(String(format: NSLocalizedString("ConnectionView_ConnectedConsole", comment: ""), consoleName))
                .font(.headline)
                .padding(.bottom)
              Button(action: {
                transfer()
              }) {
                Text("ConnectionView_TransferBtn")
                  .padding(.horizontal, 25)
              }
              .frame(height: 50)
              .background(Color("AccentColor"))
              .foregroundColor(Color(.white))
              .cornerRadius(25)
            }
          } else if transfered == -1 {
            Text("📲")
              .font(.custom("", size: 80))
              .padding(.bottom)
            Text(String(format: NSLocalizedString("ConnectionView_Transfering", comment: ""), consoleName))
              .font(.headline)
              .padding(.bottom)
            Text(String(format: NSLocalizedString("ConnectionView_Transfering_Desc", comment: ""), consoleName))
          }
        } else if connected == -1 {
          Text("😕")
            .font(.custom("", size: 80))
            .padding(.bottom)
          Text("ConnectionView_Failed")
            .font(.headline)
            .padding(.bottom)
          Text("ConnectionView_FailedDes")
            .padding(.bottom)
            .multilineTextAlignment(.center)
          Button(action: {
            retry()
          }) {
            Text("ConnectionView_RetryBtn")
              .padding(.horizontal, 25)
          }
          .frame(height: 50)
          .background(Color("AccentColor"))
          .foregroundColor(Color(.white))
          .cornerRadius(25)
          Button(action: {
            guard let settingsUrl = URL(string: "https://github.com/Astrian/switshot/wiki/How-to-connect-to-my-Nintendo-Switch") else {
              return
            }
            UIApplication.shared.open(settingsUrl)
          }) {
            Text("ConnectionView_HelpBtn")
          }
          .padding(.top)
        }
        Spacer()
        Spacer()
      }
        .padding(.horizontal)
        .navigationTitle("ConnectionView_Title")
        .toolbar {
          ToolbarItem {
            Button(action: { showAbout = true }) {
              Image(systemName: "info.circle")
            }
          }
        }
    }
    .onAppear {
      req()
    }
    .toast(isPresenting: $showAlert){
      AlertToast(type: .regular, title: alertContent)
    }
    .sheet(isPresented: $showAbout) {
      AboutView()
    }
  }
  
  func req() {
    AF.request("http://192.168.0.1/data.json").responseJSON() { res in
      switch res.result {
        case .success(let json):
          consoleName = (json as AnyObject).value(forKey: "ConsoleName")! as! String
          files = (json as AnyObject).value(forKey: "FileNames")! as! [String]
          connected = 1
          break
        case .failure(let error):
          debug("error:\(error)")
          connected = -1
          break
        }
    }
  }
  func transfer() {
    /* guard createFolderIfNotExisits(folderPath: "Console Album") else {
      alertContent = "ConnectionView_Error_CannotCreateFolder"
      showAlert = true
      return
    } */
    transfered = -1
    for media in files {
      AF.download("http://192.168.0.1/img/\(media)" ).responseData { response in
        if response.error == nil {
          importer(name: media, data: response.value!, saveCopy: UserDefaults.standard.bool(forKey: "pref_savecopy"))
        }
      }
    }
    transfered = 1
  }
  func retry() {
    connected = 0
    req()
  }
}
