//
//  DetailView.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/23.
//

import SwiftUI
import LinkPresentation
import RealmSwift
import CoreMedia

struct DetailView: View {
  @State var log: TransferLog
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  @State var fullPath = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.absoluteString
  @State var showQL = false
  @State var QLFilename = ""
  @State var alertVisible = false
  @State var shareAllActionSheetVisible = false
  @State var shareOneActionSheetVisible = false
  @State var deleteOneConfirmVisible = false
  @State var deleteEntireConfirmVisible = false
  @State var quickLookVisible = false
  @State var mediaOperating: TransferedMedia?
  @ObservedResults(TransferedMedia.self) var medias
  @ObservedResults(TransferLog.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var logs
  @Environment(\.presentationMode) private var presentationMode
  private let columnGrid = [GridItem(.flexible(), spacing: 4), GridItem(.flexible(), spacing: 4)]
  
  var body: some View {
    ScrollView {
      VStack {
        LazyVGrid(columns: columnGrid) {
          ForEach(log.media) { media in
            if getPreview(media: media.id, type: media.type) != nil {
              let image = getPreview(media: media.id, type: media.type)!
              Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .contextMenu(menuItems: {
                  Button(role: .destructive) {
                    if (log.media.count > 1) {
                      mediaOperating = media
                      deleteOneConfirmVisible.toggle()
                    } else {
                      deleteEntireConfirmVisible.toggle()
                    }
                    alertVisible.toggle()
                  } label: {
                    Label("DetailView_ContextMenu_Delete", systemImage: "trash")
                  }
                  Button(action: {
                    mediaOperating = media
                    shareOneActionSheetVisible.toggle()
                  }) {
                    Label("DetailView_ContextMenu_Share", systemImage: "square.and.arrow.up")
                  }
                  Button {
                    saveToLibrary([media])
                  } label: {
                    Label("DetailView_ContextMenu_Save", systemImage: "square.and.arrow.down")
                  }
                })
                .onTapGesture {
                  mediaOperating = media
                  quickLookVisible.toggle()
                }
            }
          }
        }
        
        // TODO: If you not to use @State variables in here, it will not updated in sheets.
        if mediaOperating != nil { Text(mediaOperating!.id.uuidString).foregroundColor(.primary.opacity(0)).frame(width: 0, height: 0) }
      }
    }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Button(action: {
              shareAllActionSheetVisible.toggle()
            }) {
              Label("DetailView_Shareall", systemImage: "square.and.arrow.up.on.square")
            }
            Menu {
              Button { saveToLibrary(nil) } label: {
                Label("DetailView_Saveall", systemImage: "square.and.arrow.down.on.square")
              }
              Button(role: .destructive) {
                deleteEntireConfirmVisible.toggle()
                alertVisible.toggle()
              } label: {
                Label("DetailView_Menu_Delete", systemImage: "trash")
              }
            } label: {
              Image(systemName: "ellipsis.circle")
            }
          }
        }
      }
      .sheet(isPresented: $shareAllActionSheetVisible) {
        ActivityViewController(activityItems: getAllMediaMeta()).ignoresSafeArea()
      }
      .sheet(isPresented: $shareOneActionSheetVisible) {
        ActivityViewController(activityItems: getOneImageMediaMeta(item: mediaOperating!)).ignoresSafeArea()
      }
      .sheet(isPresented: $quickLookVisible) {
        QuickLookComp(uuid: mediaOperating!.id, mediaType: mediaOperating!.type)
      }
      .alert(isPresented: $alertVisible) {
        if deleteEntireConfirmVisible {
          return Alert(
            title: Text("DetailView_DelEntireAlert_Title"),
            message: Text("DetailView_DelEntireAlert_Msg"),
            primaryButton: .default(Text("DetailView_DelEntireAlert_Cancel"), action: {
              mediaOperating = nil
              deleteEntireConfirmVisible = false
            }),
            secondaryButton: .destructive(Text("DetailView_DelEntireAlert_Confirm"), action: {
              deleteEntire()
              deleteEntireConfirmVisible = false
            })
          )
        } else if deleteOneConfirmVisible {
          return Alert(
            title: Text("DetailView_DelOneAlert_Title"),
            message: Text("DetailView_DelOneAlert_Msg"),
            primaryButton: .default(Text("DetailView_DelOneAlert_Cancel"), action: {
              mediaOperating = nil
              deleteOneConfirmVisible = false
            }),
            secondaryButton: .destructive(Text("DetailView_DelOneAlert_Confirm"), action: {
              deleteSingle()
              deleteOneConfirmVisible = false
            })
          )
        } else {
          return Alert(title: Text("Unknown operation"))
        }
      }
  }
  
  func getPreview(media: UUID, type: String) -> UIImage? {
    if type == "photo" {
      let manager = FileManager.default
      guard let data = manager.contents(atPath: "\(path)/media/\(media.uuidString).\(type == "photo" ? "jpg" : "mp4")") else {
        print("No such file")
        return nil
      }
      guard let res = UIImage(data: data) else {
        print("cannot read file")
        return nil
      }
      return res
    } else if type == "movie" {
      return imageFromVideo(url: URL(string: "\(fullPath)/media/\(media.uuidString).\(type == "photo" ? "jpg" : "mp4")")!, at: 0)
    } else {
      print("Unknown format")
      return nil
    }
  }
  
  func getAllMediaMeta() -> [LinkPresentationItemSource] {
    var metadatas = [LinkPresentationItemSource]()
    for item in log.media {
      let manager = FileManager.default
      guard let data = manager.contents(atPath: "\(path)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")  else {
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
  
  func getOneImageMediaMeta(item: TransferedMedia) -> [LinkPresentationItemSource] {
    let manager = FileManager.default
    let filepath = "\(path)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")"
    print(item.type)
    guard let data = manager.contents(atPath: filepath)  else {
      print("No such file")
      print(filepath)
      return [LinkPresentationItemSource]()
    }
    let metadata = LPLinkMetadata()
    metadata.iconProvider = NSItemProvider(contentsOf: URL(string: "\(fullPath)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")!)
    metadata.title = String(NSLocalizedString("DetailView_QuickLookComp_Share_Title", comment: ""))
    metadata.originalURL = URL(string: "\(fullPath)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")!
    return [LinkPresentationItemSource(linkMetaData: metadata, shareData: data)]
  }
  
  func deleteSingle() {
    guard let media = mediaOperating else { return }
    do {
      let manager = FileManager.default
      print("Removing file")
      try manager.removeItem(atPath: "\(path)/media/\(media.id.uuidString).\(media.type == "photo" ? "jpg" : "mp4")")
      print("Removing media in log")
      for i in (0 ..< log.media.count) {
        print("i = \(i)")
        if log.media[i].id.uuidString == media.id.uuidString {
          $log.media.remove(at: i)
        }
      }
      print("Removing entire media in database")
      $medias.remove(media)
      mediaOperating = nil
    } catch { return }
  }
  
  func deleteEntire() {
    let manager = FileManager.default
    for item in log.media {
      do {
        print("Removing file")
        try manager.removeItem(atPath: "\(path)/media/\(item.id.uuidString).\(item.type == "photo" ? "jpg" : "mp4")")
        print("Removing media in log")
        $log.media.remove(at: 0)
        print("Removing entire media in database")
        $medias.remove(item)
      } catch {
        continue
      }
    }
    $logs.remove(log)
    presentationMode.wrappedValue.dismiss()
  }
  
  func saveToLibrary(_ list: [TransferedMedia]?) {
    let manager = FileManager.default
    if list != nil { 
      for i in list! {
        guard let data = manager.contents(atPath: "\(path)/media/\(i.id.uuidString).\(i.type == "photo" ? "jpg" : "mp4")") else {
          print("No such file")
          continue
        }
        if i.type == "photo" {
          UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
        } else if i.type == "movie" {
          saveVideo(i.id)
        }
      }
    } else {
      for i in log.media {
        guard let data = manager.contents(atPath: "\(path)/media/\(i.id.uuidString).\(i.type == "photo" ? "jpg" : "mp4")") else {
          print("No such file")
          continue
        }
        if i.type == "photo" {
          UIImageWriteToSavedPhotosAlbum(UIImage(data: data)!, nil, nil, nil)
        } else if i.type == "movie" {
          saveVideo(i.id)
        }
      }
    }
  }
}
