//
//  GallaryComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift

struct GalleryComp: View {
  @ObservedRealmObject var list: TransferLogList
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("HomeView_GalleryComp_Title").font(.title).bold().padding(.bottom, 4)
      if list.logs.count != 0 {
        ForEach(list.logs) { log in
          Text("hi")
        }
      } else {
        VStack(spacing: 4) {
          Text("HomeView_GalleryComp_Empty").font(Font.title2)
          Text("HomeView_GalleryComp_Empty_Desc").foregroundColor(Color.gray)
        }.frame(maxWidth: .infinity).padding(.top, 30)
      }
    }.frame(maxWidth: .infinity)
  }
}
