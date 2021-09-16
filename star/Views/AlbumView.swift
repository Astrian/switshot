//
//  AlbumView.swift
//  AlbumView
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import AlertToast
import ImageViewer
import Introspect
import AVFoundation
import Photos
import AVKit

struct AlbumView: View {
  @State private var images = [String: Data]()
  @State private var imagesName = [String]()
  @State private var videos = [String: UIImage]()
  @State private var videosName = [String]()
  @State private var pickerValue = 0
  @State private var showToast = false
  @State private var alertContent = ""
  @State private var imagePreview = Image(systemName: "image")
  @State private var showPreview = false
  @State private var showVideo = false
  @State private var showVideoName = ""
  var pickerOptions = [
    String(format: NSLocalizedString("AlbumView_Picker_Image", comment: "")),
    String(format: NSLocalizedString("AlbumView_Picker_Video", comment: ""))
  ]

  var body: some View {
    NavigationView {
      Group {
        if (pickerValue == 0 && imagesName.count != 0) || (pickerValue == 1 && videosName.count != 0) {
          ScrollView {
            let column = [GridItem(), GridItem()]
            LazyVGrid(columns: column) {
              if pickerValue == 0 {
                ForEach (imagesName, id: \.self) { item in
                  Image(uiImage: (UIImage(data: images[item]!) ?? UIImage(systemName: "photo"))!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: ((UIScreen.screenWidth - 36) / 2))
                    .clipped()
                    .onTapGesture{
                      imagePreview = Image(uiImage: (UIImage(data: images[item]!) ?? UIImage(systemName: "photo"))!)
                      showPreview = true
                    }
                    .contextMenu{
                      Button(action: {
                        self.delete(item: item)
                      }) {
                        HStack {
                          Text("AlbumView_BtnDelete")
                          Image(systemName: "trash")
                        }
                      }
                      
                      Button(action: {
                        saveImage(images[item]!)
                      }) {
                        HStack {
                          Text("AlbumView_BtnSaveToPhoto")
                          Image(systemName: "square.and.arrow.down")
                        }
                      }
                      
                      Button(action: {
                        let activityController = UIActivityViewController(activityItems: [UIImage(data: images[item]!) as Any], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
                      }) {
                        HStack {
                          Text("AlbumView_BtnShare")
                          Image(systemName: "square.and.arrow.up")
                        }
                      }
                    }
                }
              } else if pickerValue == 1 {
                ForEach (videosName, id: \.self) { item in
                  let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
                  let fileUrl = documentPath as String
                  NavigationLink(destination: VideoPlayerView(url: "\(fileUrl)/\(item)")) {
                    Image(uiImage: (videos[item] ?? UIImage(systemName: "photo"))!)
                      .resizable()
                      .scaledToFill()
                      .frame(width: ((UIScreen.screenWidth - 36) / 2))
                      .clipped()
                  }
                    .contextMenu{
                      Button(action: {
                        self.delete(item: item)
                      }) {
                        HStack {
                          Text("AlbumView_BtnDelete")
                          Image(systemName: "trash")
                        }
                      }
                      
                      Button(action: {
                        saveVideo(item)
                      }) {
                        HStack {
                          Text("AlbumView_BtnSaveToPhoto")
                          Image(systemName: "square.and.arrow.down")
                        }
                      }
                      
                      Button(action: {
                        let activityController = UIActivityViewController(activityItems: [UIImage(data: images[item]!) as Any], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
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
            .padding(.horizontal)
            if pickerValue == 0 {
              Text(String(format: NSLocalizedString("AlbumView_Count_Image", comment: ""), imagesName.count))
                .padding(.top)
                .font(Font.custom("", size: 20))
                .foregroundColor(Color.gray)
            } else if pickerValue == 1 {
              Text(String(format: NSLocalizedString("AlbumView_Count_Video", comment: ""), videosName.count))
                .padding(.top)
                .font(Font.custom("", size: 20))
                .foregroundColor(Color.gray)
            }
          }
        } else {
          VStack {
            Spacer()
            Text("📂")
              .font(.custom("", size: 80))
              .padding(.bottom)
            Text("AlbumView_Empty_Title")
              .font(.headline)
              .padding(.bottom)
            Text("AlbumView_Empty_Desc")
            Spacer()
            Spacer()
          }
        }
      }
      .frame(minWidth: 0, maxWidth: .infinity)
      .navigationTitle("AlbumView_Title")
      .toolbar {
        ToolbarItem {
          Picker("Picker", selection: $pickerValue) {
            ForEach(0..<pickerOptions.count) { index in
              Text(pickerOptions[index]).tag(index)
            }
          }.pickerStyle(SegmentedPickerStyle())
        }
      }
      .toast(isPresenting: $showToast){
        AlertToast(type: .regular, title: alertContent)
      }
      .navigationBarHidden(showPreview)
      .introspectTabBarController { (UITabBarController) in
        UITabBarController.tabBar.isHidden = showPreview
      }
      .overlay(ImageViewer(image: $imagePreview, viewerShown: self.$showPreview))
    }
    .onAppear{
      refresh()
    }
  }
  
  private func delete(item media: String) {
    guard deleteFile(fileName: media) else {
      showToast = true
      alertContent = "AlbumView_Error_CannotDelete"
      return
    }
    // showToast = true
    // alertContent = "AlbumView_Toast_Deleted"
    refresh()
  }
  
  private func refresh() {
    images = [String: Data]()
    imagesName = [String]()
    videos = [String: UIImage]()
    videosName = [String]()
    let array = getAllFileName()
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let fileUrl = documentPath as String
    let manager = FileManager.default
    for item in array {
      guard let data = manager.contents(atPath: "\(fileUrl)/\(item)") else {
        continue
      }
      if item.split(separator: ".")[1] == "jpg" {
        imagesName.append(item)
        images.updateValue(data, forKey: item)
      } else if item.split(separator: ".")[1] == "mp4" {
        videosName.append(item)
        debug("\(fileUrl)/\(item)")
        imageFromVideo(url: URL(fileURLWithPath:"\(fileUrl)/\(item)"), at: 0) { image in
          videos.updateValue(image! , forKey: item)
          // Do something with the image here
        }
        // videos.updateValue(imageFromVideo(url: URL(string: "\(fileUrl)/\(item)")!, at: 0)!, forKey: item)
      }
    }
  }
  
  private func saveImage(_ inputImage: Data) {
    UIImageWriteToSavedPhotosAlbum(UIImage(data: inputImage)!, nil, nil, nil)
  }
  
  
  private func saveVideo(_ inputVideo: String) {
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
    let fileUrl = documentPath as String
    PHPhotoLibrary.shared().performChanges({
      PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: "\(fileUrl)/\(inputVideo)"))
    }) { saved, error in }
  }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

func imageFromVideo(url: URL, at time: TimeInterval, completion: @escaping (UIImage?) -> Void) {
  DispatchQueue.global(qos: .background).async {
    let asset = AVURLAsset(url: url)

    let assetIG = AVAssetImageGenerator(asset: asset)
    assetIG.appliesPreferredTrackTransform = true
    assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

    let cmTime = CMTime(seconds: time, preferredTimescale: 60)
    let thumbnailImageRef: CGImage
    do {
      thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
    } catch let error {
      debug("Error: \(error)")
      return completion(nil)
    }

    DispatchQueue.main.async {
      completion(UIImage(cgImage: thumbnailImageRef))
    }
  }
}
