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
  @ObservedResults(TransferedMediaList.self) var medias
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          Divider()
          if lists.first != nil && medias.first != nil {
            let list = lists.first!
            let media = medias.first!
            ConnectionComp(list: list, mediaList: media)
            Divider()
            RecentComp(list: list, mediaList: media)
          } else {
            HStack {
              ProgressView().onAppear{
                if lists.first == nil {
                  $lists.append(TransferLogList())
                }
                if medias.first == nil {
                  $medias.append(TransferedMediaList())
                }
              }
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
