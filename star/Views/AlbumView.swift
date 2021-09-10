//
//  AlbumView.swift
//  AlbumView
//
//  Created by Astrian Zheng on 2021/9/10.
//

import SwiftUI
import AlertToast

struct AlbumView: View {
  @State private var images = [String: Data]()
  @State private var imagesName = [String]()
  @State private var videos = [String: Data]()
  @State private var videosName = [String]()
  @State private var pickerValue = 0
  @State private var showToast = false
  @State private var alertContent = ""
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
              ForEach (imagesName, id: \.self) { item in
                if pickerValue == 0 {
                  Image(uiImage: (UIImage(data: images[item]!) ?? UIImage(systemName: "photo"))!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: ((UIScreen.screenWidth - 36) / 2))
                    .clipped()
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
            .padding(.horizontal)
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
    }
    .onAppear{
      refresh()
    }
  }
  
  func delete(item media: String) {
    guard deleteFile(fileName: media) else {
      showToast = true
      alertContent = "AlbumView_Error_CannotDelete"
      return
    }
    // showToast = true
    // alertContent = "AlbumView_Toast_Deleted"
    refresh()
  }
  
  func refresh() {
    images = [String: Data]()
    imagesName = [String]()
    videos = [String: Data]()
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
        videos.updateValue(data, forKey: item)
      }
    }
  }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
