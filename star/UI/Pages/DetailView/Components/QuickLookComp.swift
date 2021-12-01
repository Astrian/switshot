//
//  QuickLookComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import SwiftUI
import LinkPresentation

struct QuickLookComp: View {
  @State var url: URL
  @State var mediaType: String
  @State var actionSheetVisible = false
  @Environment(\.presentationMode) private var presentationMode
  
  var body: some View {
    ZStack {
      PreviewController(url: url)
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
                UIImageWriteToSavedPhotosAlbum(getUIImage(), nil, nil, nil)
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
    let shareData = manager.contents(atPath: url.path)!
    if mediaType == "image" {
      return UIImage(data: shareData)!
    } else {
      return imageFromVideo(url: url, at: 0)!
    }
  }
  
  func getShareMedia() -> LinkPresentationItemSource {
    let metadata = LPLinkMetadata()
    metadata.iconProvider = NSItemProvider(contentsOf: url)
    metadata.title = String(NSLocalizedString("DetailView_QuickLookComp_Share_Title", comment: ""))
    metadata.originalURL = url
    return LinkPresentationItemSource(linkMetaData: metadata, shareData: getUIImage())
  }
}
