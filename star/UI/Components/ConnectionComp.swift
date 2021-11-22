//
//  ConnectionComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI

struct ConnectionComp: View {
  @State var status = 3
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
          Text("You’re now connected to “Astrian’s Console”.").foregroundColor(Color.gray)
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
          Text("View your transfered media in Gallary session below.").foregroundColor(Color.gray)
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
            Button(action: {}) {
              Text("Try again").bold().padding([.horizontal], 18)
            }.frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
            Button(action: {}) {
              Text("Need help")
            }
          }
        }
      }
    
    }
  }
}

struct ConnectionComp_Previews: PreviewProvider {
  static var previews: some View {
    ConnectionComp()
  }
}
