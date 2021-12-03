//
//  QuickLookComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import SwiftUI
import LinkPresentation

struct QuickLookComp: View {
  @State var fullPath = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.absoluteString
  @State var uuid: UUID
  @State var mediaType: String
  @State var actionSheetVisible = false
  @Environment(\.presentationMode) private var presentationMode
  
  var body: some View {
    ZStack {
      PreviewController(url: URL(string: "\(fullPath)/media/\(uuid.uuidString).\(mediaType == "photo" ? "jpg" : "mp4")")!)
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
      
      VStack {
        HStack {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Text("DetailView_QuickLookComp_Dismiss").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
          }
          Spacer()
          HStack {
            Button(action: {
              actionSheetVisible.toggle()
            }) {
              Label("DetailView_QuickLookComp_Share", systemImage: "square.and.arrow.up").labelStyle(.titleAndIcon).foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
            Menu {
              Button {
                if mediaType == "photo" {
                  UIImageWriteToSavedPhotosAlbum(getUIImage(), nil, nil, nil)
                } else if mediaType == "movie" {
                  saveVideo(uuid)
                }
              } label: {
                Label("DetailView_QuickLookComp_Menu_Save", systemImage: "square.and.arrow.down")
              }
              /* Button(role: .destructive) {} label: {
                Label("DetailView_QuickLookComp_Menu_Delete", systemImage: "trash")
              } */
            } label: {
              Image(systemName: "ellipsis.circle").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
          }
        }.padding()
        Spacer()
      }
    }
      .sheet(isPresented: $actionSheetVisible) {
        ActivityViewController(activityItems: [getShareMedia()]).ignoresSafeArea()
      }
      
  }
  
  func getUIImage() -> UIImage {
    let manager = FileManager.default
    let shareData = manager.contents(atPath: URL(string: "\(fullPath)/media/\(uuid.uuidString).\(mediaType == "photo" ? "jpg" : "mp4")")!.path)!
    if mediaType == "image" {
      return UIImage(data: shareData)!
    } else {
      return imageFromVideo(url: URL(string: "\(fullPath)/media/\(uuid.uuidString).\(mediaType == "photo" ? "jpg" : "mp4")")!, at: 0)!
    }
  }
  
  func getShareMedia() -> LinkPresentationItemSource {
    let metadata = LPLinkMetadata()
    metadata.iconProvider = NSItemProvider(contentsOf: URL(string: "\(fullPath)/media/\(uuid.uuidString).\(mediaType == "photo" ? "jpg" : "mp4")")!)
    metadata.title = String(NSLocalizedString("DetailView_QuickLookComp_Share_Title", comment: ""))
    metadata.originalURL = URL(string: "\(fullPath)/media/\(uuid.uuidString).\(mediaType == "photo" ? "jpg" : "mp4")")
    return LinkPresentationItemSource(linkMetaData: metadata, shareData: getUIImage())
  }
}
