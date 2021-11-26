//
//  DetailView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/23.
//

import SwiftUI

struct DetailView: View {
  @State var log: TransferLog
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  private let columnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
  
  var body: some View {
    ScrollView {
      VStack {
        LazyVGrid(columns: columnGrid) {
          ForEach(log.media) { media in
            let image = getPreview(media: media.id, type: media.type)!
            Image(uiImage: image)
              .resizable()
              .scaledToFit()
          }
        }
      }
    }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Button(action: {}) {
              Label("DetailView_Shareall", systemImage: "square.and.arrow.up").labelStyle(.titleAndIcon).padding(4).background(Color.gray.opacity(0.1)).cornerRadius(8)
            }
            Menu {
              Button(role: .destructive) {} label: {
                Label("DetailView_Menu_Delete", systemImage: "trash")
              }
            } label: {
              Image(systemName: "ellipsis.circle")
            }
          }
        }
      }
  }
  
  func getPreview(media: UUID, type: String) -> UIImage? {
    let manager = FileManager.default
    guard let data = manager.contents(atPath: "\(path)/media/\(media.uuidString).\(type == "photo" ? "jpg" : "mp4")") else {
      print("No such file")
      return nil
    }
    if type == "photo" {
      print(data)
      guard let res = UIImage(data: data) else {
        print("cannot read file")
        return nil
      }
      return res
    } else {
      print("Unknown format")
      return nil
    }
  }
}
