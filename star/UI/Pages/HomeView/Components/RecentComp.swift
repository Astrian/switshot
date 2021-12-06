//
//  GallaryComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift

struct RecentComp: View {
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  @State var fullPath = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.absoluteString
  @State var showDetail = false
  @ObservedResults(TransferLog.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var logs
  @ObservedResults(TransferedMedia.self) var medias
  @State var showDelAlert = false
  @State var deleteTarget: TransferLog?
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("HomeView_RecentComp_Title").font(.title).bold().padding(.bottom, 4)
        Spacer()
      }
      if logs.elements.count != 0 {
        VStack(spacing: 18) {
          ForEach(0 ..< logs.elements.count) { index in
            let target = logs.elements[index]
            if getPreview(log: target) != nil {
              NavigationLink(destination: DetailView(log: target)) {
                VStack(alignment: .leading, spacing: 0) {
                  Image(uiImage: getPreview(log: target)!).resizable().aspectRatio(contentMode: .fit)
                  HStack(spacing: 0) {
                    Text(dateFormatter(date: target.date))
                    Spacer()
                    if target.media.count > 1{
                      Text(" +\(target.media.count - 1)")
                    }
                  }.foregroundColor(Color.primary).padding()
                }
                .background(Color("CardBackground")).cornerRadius(8).clipped().shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .contextMenuWithPreview(actions: [
                  UIAction(
                    title: NSLocalizedString("HomeView_RecentComp_Menu_Delete", comment: ""),
                    image: UIImage(systemName: "trash"),
                    identifier: nil,
                    attributes: UIMenuElement.Attributes.destructive,
                    handler: {_ in
                      deleteTarget = target
                      showDelAlert.toggle()
                    })
                  /* UIAction(title: NSLocalizedString("HomeView_RecentComp_Menu_Share", comment: ""), image: UIImage(systemName: "square.and.arrow.up.on.square"), identifier: nil, handler: {_ in }),
                  UIAction(title: NSLocalizedString("HomeView_RecentComp_Menu_Save", comment: ""), image: UIImage(systemName: "square.and.arrow.down.on.square"), identifier: nil, handler: {_ in }) */
                ], preview: {
                  DetailView(log: target)
                })
              }
              .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
              .onAppear {
                print(print(index))
              }
            }
          }
          Text("•").foregroundColor(Color.gray).padding(8)
          Link("HomeView_RecentComp_WhereIsMyOldMedia", destination: URL(string: NSLocalizedString("HomeView_RecentComp_WhereIsMyOldMedia_Link", comment: ""))!).padding(.bottom, 16)
        }
      } else {
        VStack(spacing: 4) {
          Text("HomeView_RecentComp_Empty").font(Font.title2)
          Text("HomeView_RecentComp_Empty_Desc").foregroundColor(Color.gray)
        }.frame(maxWidth: .infinity).padding(.top, 30)
      }
      Text("\(logs.elements.count)").foregroundColor(Color.white.opacity(0.0)).frame(width: 0, height: 0)
    }
    .frame(maxWidth: .infinity)
    .alert(isPresented: $showDelAlert) {
      Alert(
        title: Text("HomeView_RecentComp_DelAlert_Title"),
        message: Text("HomeView_RecentComp_DelAlert_Msg"),
        primaryButton: .default(Text("HomeView_RecentComp_DelAlert_Cancel"), action: { deleteTarget = nil }),
        secondaryButton: .destructive(Text("HomeView_RecentComp_DelAlert_Confirm"), action: { deleteTransfer() }))
    }
  }
  
  func dateFormatter(date: Date) -> String {
    let rdtf = RelativeDateTimeFormatter()
    return rdtf.localizedString(for: date, relativeTo: Date())
  }
  
  func getPreview(log: TransferLog) -> UIImage? {
    let manager = FileManager.default
    guard let first = log.media.first else {
      print("No first")
      return nil
    }
    if first.type == "photo" {
      guard let data = manager.contents(atPath: "\(path)/media/\(first.id.uuidString).\(first.type == "photo" ? "jpg" : "mp4")") else {
        print("No such file 1")
        print("\(path)/media/ \(first.id.uuidString).\(first.type == "photo" ? "jpg" : "mp4")")
        return nil
      }
      guard let res = UIImage(data: data) else {
        print("cannot read file")
        return nil
      }
      return res
    } else if first.type == "movie" {
      print("movie detected")
      return imageFromVideo(url: URL(string: "\(fullPath)/media/\(first.id.uuidString).\(first.type == "photo" ? "jpg" : "mp4")")!, at: 0)
    } else {
      print("Unknown format")
      return nil
    }
  }
  
  func deleteTransfer() {
    guard let target = deleteTarget else { return }
    let manager = FileManager.default
    for media in target.media {
      do {
        try manager.removeItem(atPath: "\(path)/media/\(media.id.uuidString).\(media.type == "photo" ? "jpg" : "mp4")")
        $medias.remove(media)
      } catch {
        continue
      }
    }
    $logs.remove(target)
    deleteTarget = nil
  }
  
  func printFileNum() {
    Task {
      do {
        let directoryContents = try FileManager.default.contentsOfDirectory(atPath: "\(path)/media")
        print("media file nums: \(directoryContents.count)")
      } catch {}
    }
  }
}
