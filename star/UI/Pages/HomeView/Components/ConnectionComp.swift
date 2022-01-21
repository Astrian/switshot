//
//  ConnectionComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/22.
//

import SwiftUI
import RealmSwift
import StoreKit

struct ConnectionComp: View {
  @State var status = 0
  @State var consoleName = ""
  @State var showQRScanner = false
  @ObservedResults(TransferLog.self) var logs
  @ObservedResults(TransferedMedia.self) var medias
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("HomeView_ConnectionComp_Title").font(.title).bold().padding(.bottom, 4)
      
      // Checking connection
      if status == 0 {
        HStack(spacing: 4) {
          ProgressView()
          Text("HomeView_ConnectionComp_CheckingConnection").foregroundColor(Color.gray)
        }.padding(.bottom, 8)
      }
      
      // Connected and wait for transfer
      else if status == 1 {
        VStack(alignment: .leading, spacing: 8) {
          Text("HomeView_ConnectionComp_Ready").font(Font.title2)
          Text(String(format: NSLocalizedString("HomeView_ConnectionComp_Ready_Desc", comment: ""), consoleName)).foregroundColor(Color.gray)
          Button(action: { transferNow() }) {
            Text("HomeView_ConnectionComp_Ready_TransferBtn").bold().padding([.horizontal], 18).frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
          }
        }
      }
      
      // Transferring
      else if status == 2 {
        HStack(spacing: 4) {
          ProgressView()
          Text("HomeView_ConnectionComp_Transferring").foregroundColor(Color.gray)
        }.padding(.bottom, 8)
      }
      
      // Transferred
      else if status == 3 {
        VStack(alignment: .leading, spacing: 8) {
          Text("HomeView_ConnectionComp_Done").font(Font.title2)
          Text("HomeView_ConnectionComp_Done_Desc").foregroundColor(Color.gray)
          Button(action: { prepareTransfer() }) {
            Text("HomeView_ConnectionComp_Done_MoreBtn")
          }
        }
      }
      
      // Cannot connect to console
      else if status == -1 {
        VStack(alignment: .leading, spacing: 8) {
          Text("HomeView_ConnectionComp_Ops").font(Font.title2)
          Text("HomeView_ConnectionComp_Ops_Desc").foregroundColor(.gray).fixedSize(horizontal: false, vertical: true)
          HStack{
            Button(action: { showQRScanner = true }) {
              Text("HomeView_ConnectionComp_Ops_ScanBtn").bold().padding([.horizontal], 18).frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
            }
            Menu {
              Button(action: { prepareTransfer() }) { Label("HomeView_ConnectionComp_Ops_TryAgainBtn", systemImage: "arrow.clockwise.circle") }
              Link(destination: URL(string: NSLocalizedString("HomeView_ConnectionComp_Error_HelpBtn_Link", comment: ""))!) {
                Label("HomeView_ConnectionComp_Ops_HelpBtn", systemImage: "book.circle")
              }
            } label: {
              Label("HomeView_ConnectionComp_Ops_MenuBtn", systemImage: "questionmark.circle.fill")
            }
          }
        }
      }
      
      // Unknown Error
      else {
        VStack(alignment: .leading, spacing: 8) {
          Text("HomeView_ConnectionComp_Error").font(Font.title2)
          Text("HomeView_ConnectionComp_Error_Unknown").foregroundColor(.gray)
          HStack{
            Button(action: { prepareTransfer() }) {
              Text("HomeView_ConnectionComp_Error_TryAgainBtn").bold().padding([.horizontal], 18).frame(height: 30).background(Color.gray.opacity(0.1)).cornerRadius(15).padding(.vertical, 4)
            }
            Button(action: {}) {
              Text("HomeView_ConnectionComp_Error_HelpBtn")
            }
          }
        }
      }
    
    }
    .onAppear { prepareTransfer() }
    .sheet(isPresented: $showQRScanner, onDismiss: { prepareTransfer() }) {
      QRScannerComp().interactiveDismissDisabled()
    }
  }
  
  func prepareTransfer() {
    // Reset status
    status = 0
    
    // Try connect to console
    Task {
      do {
        guard let consoleUrl = URL(string: "http://192.168.0.1/data.json") else {
          status = -2
          return
        }
        let request = URLRequest(url: consoleUrl)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 1.0
        sessionConfig.timeoutIntervalForResource = 1.0
        let session = URLSession(configuration: sessionConfig)
        let (data, response) = try await session.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
          status = -1
          return
        }
        let res = try JSONDecoder().decode(ConsoleResponse.self, from: data)
        consoleName = res.ConsoleName
        status = 1
      } catch {
        status = -1
      }
    }
  }
  
  func transferNow() {
    status = 2
    Task {
      do {
        let transferRes = try await transfer(saveCopy: UserDefaults.standard.bool(forKey: "pref_savecopy"))
        var i = 0
        let log = TransferLog()
        for (uuid, _) in transferRes.data {
          print("uuid = \(uuid)")
          let media = TransferedMedia()
          media.code = i
          media.id = uuid
          media.type = transferRes.mediaType
          $medias.append(media)
          log.media.append(media)
          i += 1
        }
        $logs.append(log)
        status = 3
        reviewGatcha()
      } catch {
        status = -1
      }
    }
  }
  
  func reviewGatcha() {
    let random = arc4random_uniform(100)
    print(random)
    if random >= 98 {
      print("gatcha!")
      guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        print("cannot get scene")
        return
      }
      SKStoreReviewController.requestReview(in: scene)
    }
  }
}

/* struct ConnectionComp_Previews: PreviewProvider {
  static var previews: some View {
    // ConnectionComp()
  }
} */
