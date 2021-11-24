//
//  HomeView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/19.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
  @ObservedResults(TransferLogList.self) var lists
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          Divider()
          if let list = lists.first {
            ConnectionComp(list: list)
            Divider()
            GalleryComp(list: list)
          } else {
            HStack {
              ProgressView().onAppear{ $lists.append(TransferLogList()) }
              Text("初始化...")
            }.padding(.top, 100)
          }
        }.frame(maxWidth: .infinity).padding([.horizontal])
      }.navigationTitle("HomeView_Title")
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
