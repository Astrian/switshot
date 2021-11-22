//
//  HomeView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/19.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading) {
          Divider()
          
          ConnectionComp()
          
          Divider()
          
          GallaryComp()
          
          // Gallary (transfer history)
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
