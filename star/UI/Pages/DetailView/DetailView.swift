//
//  DetailView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/23.
//

import SwiftUI
import LinkPresentation

struct DetailView: View {
  @State var log: TransferLog
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  @State var fullPath = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.absoluteString
  private let columnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
  @State var showQL = false
  @State var QLFilename = ""
  @State var showShareAllActionSheet = false
  
  var body: some View {
    ScrollView {
      VStack {
        LazyVGrid(columns: columnGrid) {
          ForEach(log.media) { media in
            let image = getPreview(media: media.id, type: media.type)!
            NavigationLink(destination: QuickLookComp(url: URL(string: "\(fullPath)/media/\(media.id.uuidString).\(media.type == "photo" ? "jpg" : "mp4")")!)) {
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
            }
          }
        }
      }
    }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Button(action: {
              showShareAllActionSheet.toggle()
            }) {
              Label("DetailView_Shareall", systemImage: "square.and.arrow.up.on.square")
            }
            Menu {
              Button {} label: {
                Label("DetailView_Saveall", systemImage: "square.and.arrow.down.on.square")
              }
              Button(role: .destructive) {} label: {
                Label("DetailView_Menu_Delete", systemImage: "trash")
              }
            } label: {
              Image(systemName: "ellipsis.circle")
            }
          }
        }
      }
      .sheet(isPresented: $showShareAllActionSheet) {
        ActivityViewController(activityItems: getAllMediaMeta()).ignoresSafeArea()
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
  
  func getAllMediaMeta() -> [LinkPresentationItemSource] {
    var metadatas = [LinkPresentationItemSource]()
    for item in log.media {
      let manager = FileManager.default
      guard let data = manager.contents(atPath: "\(path)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")") else {
        print("No such file")
        continue
      }
      let metadata = LPLinkMetadata()
      metadata.iconProvider = NSItemProvider(contentsOf: URL(string: "\(path)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")!)
      metadata.title = String(NSLocalizedString("DetailView_QuickLookComp_Share_Title", comment: ""))
      metadata.originalURL = URL(string: "\(fullPath)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")!
      metadatas.append(LinkPresentationItemSource(linkMetaData: metadata, shareData: data))
    }
    return metadatas
  }
}
