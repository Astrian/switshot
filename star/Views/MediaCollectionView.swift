//
//  MediaDetailView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/18.
//

import SwiftUI

struct MediaCollectionView: View {
  var body: some View {
    NavigationView {
      List {
        Text("aaa")
      }
      .navigationBarTitle(Text("MediaCollectionView_Title"))
    }
  }
}

struct MediaDetailView_Previews: PreviewProvider {
  static var previews: some View {
    MediaCollectionView()
  }
}
