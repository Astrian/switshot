//
//  ContentView.swift
//  lucifer
//
//  Created by Astrian Zheng on 2022/1/23.
//

import SwiftUI

struct ContentView: View {
  @State var status = 0
  
  var body: some View {
    NavigationView {
      Group {
        switch status {
        case 0:
          ProgressView("Connecting")
        default:
          Text("Default")
        }
      }
      .navigationTitle("AppName")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
