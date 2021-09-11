//
//  ImageDetailView.swift
//  ImageDetailView
//
//  Created by Astrian Zheng on 2021/9/11.
//

import SwiftUI
import Introspect
import LinkPresentation
import AlertToast

struct ImageDetailView: View {
  var image: Data
  var filename: String
  @State private var showToast = false
  @State private var alertContent = ""
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var refresh: () -> Void
  @GestureState var magnifyBy = CGFloat(1.0)
  
  var magnification: some Gesture {
    MagnificationGesture()
      .updating ($magnifyBy) {
        currentState, gestureState,
        transaction in
        gestureState = currentState
      }
  }
  
  var body: some View {
    ScrollView ([.horizontal, .vertical]) {
      Image(uiImage: UIImage(data: image)!)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: UIScreen.screenWidth * magnifyBy)
        .gesture(magnification)
    }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          HStack {
            Button(action: {
              delete(item: filename)
            }) {
              Image(systemName: "trash")
              // Text("ImageDetailView_BtnDelete")
            }
            Spacer()
            Button(action: {
              let activityController = UIActivityViewController(activityItems: [UIImage(data: Data(image)) as Any], applicationActivities: nil)
              UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
            }) {
              Image(systemName: "square.and.arrow.up")
              // Text("ImageDetailView_BtnShare")
            }
            Button(action: {
              saveImage(image)
            }) {
              Image(systemName: "square.and.arrow.down")
              // Text("ImageDetailView_BtnSaveToPhoto")
            }
          }
        }
      }
      .toast(isPresenting: $showToast){
        AlertToast(type: .regular, title: alertContent)
      }
  }
  
  private func saveImage(_ inputImage: Data) {
    UIImageWriteToSavedPhotosAlbum(UIImage(data: inputImage)!, nil, nil, nil)
  }
  
  private func delete(item media: String) {
    guard deleteFile(fileName: media) else {
      showToast = true
      alertContent = "AlbumView_Error_CannotDelete"
      return
    }
    refresh()
    presentationMode.wrappedValue.dismiss()
  }
}
