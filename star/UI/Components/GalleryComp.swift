//
//  GallaryComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift

struct GalleryComp: View {
  @ObservedRealmObject var list: TransferLogList
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("HomeView_GalleryComp_Title").font(.title).bold().padding(.bottom, 4)
        Spacer()
      }
      if list.logs.count != 0 {
        VStack(spacing: 18) {
          ForEach(list.logs) { log in
            VStack(alignment: .leading, spacing: 0) {
              Image(uiImage: getPreview(log: log)!).resizable().aspectRatio(contentMode: .fit)
              HStack(spacing: 0) {
                Text(dateFormatter(date: log.date))
                Text(" · ")
                Text("\(log.media.count) 份媒体")
              }.padding()
            }.background(Color("CardBackground")).cornerRadius(8).clipped().shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 1)
          }
          Text("❦").foregroundColor(Color.gray).padding()
        }
      } else {
        VStack(spacing: 4) {
          Text("HomeView_GalleryComp_Empty").font(Font.title2)
          Text("HomeView_GalleryComp_Empty_Desc").foregroundColor(Color.gray)
        }.frame(maxWidth: .infinity).padding(.top, 30)
      }
    }.frame(maxWidth: .infinity)
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
    guard let data = manager.contents(atPath: "\(path)/media/\(first.id.uuidString).\(first.type == "photo" ? "jpg" : "mp4")") else {
      print("No such file")
      print("\(path)/media/ \(first.id.uuidString).\(first.type == "photo" ? "jpg" : "mp4")")
      return nil
    }
    if first.type == "photo" {
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
