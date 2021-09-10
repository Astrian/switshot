//
//  ConnectionView.swift
//  ConnectionView
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import SystemConfiguration
import Alamofire

struct ConnectionView: View {
  @State private var connected = 0
  @State private var transfered = 0
  @State private var consoleName = ""
  @State private var files = [String]()
  
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
            Text("transfered!")
          } else if transfered == 0{
            VStack {
              Text("🪄")
                .font(.custom("", size: 80))
                .padding(.bottom)
              Text(String(format: NSLocalizedString("ConnectionView_ConnectedConsole", comment: ""), consoleName))
                .font(.headline)
                .padding(.bottom)
              Button(action: {}) {
                Text("ConnectionView_TransferBtn")
                  .padding(.horizontal, 25)
              }
              .frame(height: 50)
              .background(Color("AccentColor"))
              .foregroundColor(Color(.white))
              .cornerRadius(25)
            }
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
        }
        Spacer()
        Spacer()
      }
      .padding(.horizontal)
        .navigationTitle("ConnectionView_Title")
    }
    .onAppear {
      req()
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
    
  }
  func retry() {
    connected = 0
    req()
  }
}
