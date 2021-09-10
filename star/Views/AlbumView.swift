//
//  AlbumView.swift
//  AlbumView
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI

struct AlbumView: View {
  @State private var media = [Data]()

  var body: some View {
    NavigationView {
      ScrollView {
        let column = [GridItem(), GridItem()]
        LazyVGrid(columns: column) {
          ForEach (media, id: \.self) { item in
            Image(uiImage: (UIImage(data: item) ?? UIImage(systemName: "photo"))!)
              .resizable()
              .scaledToFill()
              .frame(width: ((UIScreen.screenWidth - 36) / 2))
              .clipped()
              .contextMenu{
                Button(action: {
                   // bla
                }) {
                  HStack {
                    Text("AlbumView_BtnDelete")
                    Image(systemName: "trash")
                  }
                }
                
                Button(action: {
                   // bla
                }) {
                  HStack {
                    Text("AlbumView_BtnSaveToPhoto")
                    Image(systemName: "square.and.arrow.down")
                  }
                }
                
                Button(action: {
                   // bla
                }) {
                  HStack {
                    Text("AlbumView_BtnShare")
                    Image(systemName: "square.and.arrow.up")
                  }
                }
              }
          }
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity)
      .navigationTitle("AlbumView_Title")
      .padding(.horizontal)
    }
    .onAppear{
      let array = getAllFileName()
      let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
      let fileUrl = documentPath as String
      let manager = FileManager.default
      for item in array {
        guard let data = manager.contents(atPath: "\(fileUrl)/\(item)") else {
          continue
        }
        media.append(data)
      }
    }
  }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
