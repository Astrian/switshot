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
  private let buttonGrid = [GridItem(.flexible(), spacing: 18), GridItem(.fixed(50), spacing: 18)]
  
  var body: some View {
    ScrollView {
      VStack {
        LazyVGrid(columns: buttonGrid) {
          Button(action: {}) {
            HStack {
              Image(systemName: "square.and.arrow.up")
              Text("分享").bold()
            }.frame(maxWidth: .infinity, minHeight: 50)
          }.background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
          Menu {
            Button(action: {}) {
              HStack {
                Text("test")
                Spacer()
                Image(systemName: "ellipsis.circle")
              }
            }
          } label: {
            Label("", systemImage: "ellipsis.circle").frame(maxWidth: .infinity, minHeight: 50).background(Color.gray.opacity(0.1)).cornerRadius(15)
          }
        }.padding()
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
      .navigationTitle(Text("DetailView_Title"))
      .navigationBarTitleDisplayMode(.inline)
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
