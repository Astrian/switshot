//
//  HomeView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/19.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
  @State var aboutVisible = false
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          Divider()
          ConnectionComp()
          Divider()
          RecentComp()
        }.frame(maxWidth: .infinity).padding([.horizontal])
      }
      .navigationTitle("HomeView_Title")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            aboutVisible.toggle()
          } label: {
            Image(systemName: "info.circle")
          }
        }
      }
    }
    .sheet(isPresented: $aboutVisible) {
      AboutView(presented: $aboutVisible)
    }
  }
  
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
