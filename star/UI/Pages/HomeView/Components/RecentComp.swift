//
//  GallaryComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift
import Alamofire

struct RecentComp: View {
  @State var path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  @State var showDetail = false
  @ObservedResults(TransferLog.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var logs
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("HomeView_RecentComp_Title").font(.title).bold().padding(.bottom, 4)
        Spacer()
        Text("\(logs.elements.count)")
      }
      if logs.elements.count != 0 {
        VStack(spacing: 18) {
          ForEach(logs.elements) { target in
            NavigationLink(destination: DetailView(log: target)) {
              VStack(alignment: .leading, spacing: 0) {
                Image(uiImage: getPreview(log: target)!).resizable().aspectRatio(contentMode: .fit)
                HStack(spacing: 0) {
                  Text(dateFormatter(date: target.date))
                  if target.media.count > 1{
                    Text(" +\(target.media.count - 1)")
                  }
                }.foregroundColor(Color.primary).padding()
              }
              .background(Color("CardBackground")).cornerRadius(8).clipped().shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
              .contextMenuWithPreview(actions: [
                UIAction(title: NSLocalizedString("HomeView_RecentComp_Menu_Delete", comment: ""), image: UIImage(systemName: "trash"), identifier: nil, attributes: UIMenuElement.Attributes.destructive, handler: {_ in }),
                UIAction(title: NSLocalizedString("HomeView_RecentComp_Menu_Share", comment: ""), image: UIImage(systemName: "square.and.arrow.up.on.square"), identifier: nil, handler: {_ in }),
                UIAction(title: NSLocalizedString("HomeView_RecentComp_Menu_Save", comment: ""), image: UIImage(systemName: "square.and.arrow.down.on.square"), identifier: nil, handler: {_ in })
              ], preview: {
                DetailView(log: target)
              })
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.3)))
          }
          Text("❦").foregroundColor(Color.gray).padding()
        }
      } else {
        VStack(spacing: 4) {
          Text("HomeView_RecentComp_Empty").font(Font.title2)
          Text("HomeView_RecentComp_Empty_Desc").foregroundColor(Color.gray)
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
  
  /* func sortedList() -> [TransferLog] {
    return list.logs.sorted { (f, s) -> Bool in
      return f.date > s.date ? true : false
    }
  } */
}
