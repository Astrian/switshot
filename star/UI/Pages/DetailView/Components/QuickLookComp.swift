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
  @State var showActionSheet = false
  @Environment(\.presentationMode) private var presentationMode
  
  var body: some View {
    PreviewController(url: url)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Label("DetailView_QuickLookComp_Dismiss", systemImage: "xmark").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Button(action: {
              showActionSheet.toggle()
            }) {
              Label("DetailView_QuickLookComp_Share", systemImage: "square.and.arrow.up").labelStyle(.titleAndIcon).foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
            Menu {
              Button {
                UIImageWriteToSavedPhotosAlbum(getUIImage(), nil, nil, nil)
              } label: {
                Label("DetailView_QuickLookComp_Menu_Save", systemImage: "square.and.arrow.down")
              }
              Button(role: .destructive) {} label: {
                Label("DetailView_QuickLookComp_Menu_Delete", systemImage: "trash")
              }
            } label: {
              Image(systemName: "ellipsis.circle").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
          }
        }
      }.ignoresSafeArea()
      .sheet(isPresented: $showActionSheet) {
        ActivityViewController(activityItems: [getUIImage()], metaDatas: [getMetadata()])
      }
  }
  
  func getUIImage() -> UIImage {
    let manager = FileManager.default
    let shareData = manager.contents(atPath: url.path)!
    return UIImage(data: shareData)!
  }
  
  func getMetadata() -> LPLinkMetadata {
    let metadata = LPLinkMetadata()
    metadata.iconProvider = NSItemProvider(contentsOf: url)
    metadata.title = String(NSLocalizedString("DetailView_QuickLookComp_Share_Title", comment: ""))
    return metadata
  }
}

struct ActivityViewController: UIViewControllerRepresentable {

  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  var metaDatas: [LPLinkMetadata]

  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
    var sharedItems = [LinkPresentationItemSource]()
    for i in (0 ..< activityItems.count) {
      sharedItems.append(LinkPresentationItemSource(linkMetaData: metaDatas[i], shareData: activityItems[i]))
    }
    let controller = UIActivityViewController(activityItems: sharedItems, applicationActivities: applicationActivities)
    // controller.meta
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
