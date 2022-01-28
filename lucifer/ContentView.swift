//
//  ContentView.swift
//  lucifer
//
//  Created by Astrian Zheng on 2022/1/23.
//

import SwiftUI

struct ContentView: View {
  @State var status = 0
  @State var consoleName = ""
  
  var body: some View {
    NavigationView {
      Group {
        switch status {
        case 0:
          ProgressView("Connecting")
        case -1:
          VStack(spacing: 20) {
            Text("NotFound_Title").font(.title).bold()
            Text("NotFound_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
            Spacer()
            Button(action: { checkConnection() }) {
              HStack {
                Spacer()
                Text("RetryConnect").bold()
                Spacer()
              }.frame(height: 50).background(.quaternary).cornerRadius(8)
            }
          }
        case -2:
          Text("How you get there...")
        case 1:
          VStack(spacing: 20) {
            Text("Connected_Title").font(.title).bold()
            Text(String(format: NSLocalizedString("Connected_Desc", comment: ""), consoleName)).foregroundColor(.gray).multilineTextAlignment(.center)
            Spacer()
            Button(action: { checkConnection() }) {
              HStack {
                Spacer()
                Text("TransferNow").bold()
                Spacer()
              }.frame(height: 50).background(.quaternary).cornerRadius(8)
            }
          }
        default:
          Text("Default")
        }
      }
      .padding()
      .navigationTitle("AppName")
    }
    .onAppear {
      checkConnection()
    }
  }
  
  func checkConnection() {
    status = 0
    Task {
      do {
        guard let consoleUrl = URL(string: "http://192.168.0.1/data.json") else {
          status = -2
          return
        }
        let request = URLRequest(url: consoleUrl)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 1.0
        sessionConfig.timeoutIntervalForResource = 1.0
        let session = URLSession(configuration: sessionConfig)
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          status = -1
          return
        }
        let res = try JSONDecoder().decode(ConsoleResponse.self, from: data)
        consoleName = res.ConsoleName
        status = 1
      } catch {
        status = -1
      }
    }
  }
  
  func transfer() {
    print("transfer")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
