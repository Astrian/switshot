//
//  ConnectionComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI

struct ConnectionComp: View {
  @State var status = 0
  @State var consoleName = ""
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Transfer").font(.title).bold().padding(.bottom, 4)
      
      // Checking connection
      if status == 0 {
        HStack(spacing: 4) {
          ProgressView()
          Text("Checking connection...").foregroundColor(Color.gray)
        }.padding(.bottom, 8)
      }
      
      // Connected and wait for transfer
      else if status == 1 {
        VStack(alignment: .leading, spacing: 8) {
          Text("Ready to transfer").font(Font.title2)
          Text("You’re now connected to “\(consoleName)”.").foregroundColor(Color.gray)
          Button(action: {}) {
            Text("Transfer").bold().padding([.horizontal], 18)
          }.frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
        }
      }
      
      // Transferring
      else if status == 2 {
        HStack(spacing: 4) {
          ProgressView()
          Text("Transferring...").foregroundColor(Color.gray)
        }.padding(.bottom, 8)
      }
      
      // Connected and wait for transfer
      else if status == 3 {
        VStack(alignment: .leading, spacing: 8) {
          Text("Done!").font(Font.title2)
          Text("View your transfered media in Gallery session below.").foregroundColor(Color.gray)
          Button(action: {}) {
            Text("Transfer more media")
          }
        }
      }
      
      // Cannot connect to console
      else if status == -1 {
        VStack(alignment: .leading, spacing: 8) {
          Text("Cannot connect to console").font(Font.title2)
          Text("Make sure that your device is connecting to the local connection established by your console.").foregroundColor(.gray)
          HStack{
            Button(action: { prepareTransfer() }) {
              Text("Try again").bold().padding([.horizontal], 18)
            }.frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
            Button(action: {}) {
              Text("Need help")
            }
          }
        }
      }
      
      // Unknown Error
      else {
        VStack(alignment: .leading, spacing: 8) {
          Text("Cannot connect to console").font(Font.title2)
          Text("There are some unhandled errors. Try again later or contact developer.").foregroundColor(.gray)
          HStack{
            Button(action: { prepareTransfer() }) {
              Text("Try again").bold().padding([.horizontal], 18)
            }.frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
            Button(action: {}) {
              Text("Need help")
            }
          }
        }
      }
    
    }
    .onAppear { prepareTransfer() }
  }
  
  func prepareTransfer() {
    // Reset status
    status = 0
    
    // Try connect to console
    Task {
      do {
        guard let consoleUrl = URL(string: "http://192.168.0.1/data.json") else {
          status = -2
          return
        }
        let request = URLRequest(url: consoleUrl)
        let (data, response) = try await URLSession.shared.data(for: request)
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
}

struct ConnectionComp_Previews: PreviewProvider {
  static var previews: some View {
    ConnectionComp()
  }
}
