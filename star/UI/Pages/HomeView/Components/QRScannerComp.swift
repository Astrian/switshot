//
//  QRScannerComp.swift
//  star
//
//  Created by Astrian Zheng on 2022/1/20.
//

import SwiftUI
import CodeScanner
import NetworkExtension

struct QRScannerComp: View {
  @Environment(\.presentationMode) private var presentationMode
  @State var status = 0
  @State var deviceName = ""
  
  var body: some View {
    NavigationView {
      VStack(spacing: 40) {
        if status == 0 {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Scanning_Title").font(.title).bold()
            Text("HomeView_QRScannerComp_Scanning_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
          }
          CodeScannerView(codeTypes: [.qr]) { response in
            switch response {
            case .success(let result):
              Task {
                await scanResProcess(res: result.string)
              }
            case .failure(_):
              status = -3
            }
          }.frame(width: 300, height: 200).cornerRadius(8)
          
          Spacer()
        }
        else if status == -1 {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Scanning_Alert_Title").font(.title).bold().multilineTextAlignment(.center)
            Text("HomeView_QRScannerComp_Scanning_Alert_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
            Link(destination: URL(string: NSLocalizedString("HomeView_ConnectionComp_Error_HelpBtn_Link", comment: ""))!) {
              Text("HomeView_QRScannerComp_Scanning_Alert_HelpBtn")
            }
          }
          Spacer()
          Button(action: { status = 0 }) {
            HStack {
              Spacer()
              Text("HomeView_QRScannerComp_BackBtn").bold()
              Spacer()
            }.frame(height: 50).background(.quaternary).cornerRadius(8)
          }
        }
        else if status == -2 {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Scanning_Failed_Title").font(.title).bold().multilineTextAlignment(.center)
            Text("HomeView_QRScannerComp_Scanning_Failed_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
            Link(destination: URL(string: NSLocalizedString("HomeView_ConnectionComp_Error_HelpBtn_Link", comment: ""))!) {
              Text("HomeView_QRScannerComp_Scanning_Alert_HelpBtn")
            }
          }
          Spacer()
          Button(action: { status = 0 }) {
            HStack {
              Spacer()
              Text("HomeView_QRScannerComp_BackBtn").bold()
              Spacer()
            }.frame(height: 50).background(.quaternary).cornerRadius(8)
          }
        }
        else if status == -3 {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_ScannerError_Title").font(.title).bold().multilineTextAlignment(.center)
            Text("HomeView_QRScannerComp_ScannerError_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
            Link("HomeView_QRScannerComp_SystemSettings", destination: URL(string: UIApplication.openSettingsURLString)!)
            Link(destination: URL(string: NSLocalizedString("HomeView_ConnectionComp_Error_HelpBtn_Link", comment: ""))!) {
              Text("HomeView_QRScannerComp_Scanning_Alert_HelpBtn")
            }
          }
          Spacer()
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            HStack {
              Spacer()
              Text("HomeView_QRScannerComp_EndBtn").bold()
              Spacer()
            }.frame(height: 50).background(.quaternary).cornerRadius(8)
          }
        }
        else if status == 1 {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Wait_Title").font(.title).bold()
            Text("HomeView_QRScannerComp_Wait_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
          }
          ProgressView()
          Spacer()
        }
      }.padding()
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary, .quaternary)
          }
        }
      }
    }
  }
  
  func scanResProcess(res: String) async {
    do {
      let verifyQRRegex = try NSRegularExpression(pattern: "^WIFI:S:switch_([A-Z]|[a-z]|[0-9]){11};T:WPA;P:([a-z]|[0-9]){8};;$")
      if (verifyQRRegex.matches(in: res, range: NSRange(location: 0, length: res.count)).count == 1) {
        status = 1
        await connector(res: res)
      } else {
        status = -1
      }
    } catch {
      print("error")
    }
  }
  
  func connector(res: String) async {
    do {
      let items = (res.split(separator: ";"))
      let ssid = items[0].split(separator: ":")[2]
      let pwd = items[2].split(separator: ":")[1]
      let networkConfig = NEHotspotConfiguration(ssid: String(ssid), passphrase: String(pwd), isWEP: false)
      let hotspotInstance = NEHotspotConfigurationManager()
      try await hotspotInstance.apply(networkConfig)
      await tryConnection()
    } catch {
      status = -2
    }
  }
  
  func tryConnection() async {
    var continueFlag = true
    repeat {
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
        let (_, response) = try await session.data(for: request)
        if (response as? HTTPURLResponse)?.statusCode != 200 {
          continueFlag = true
        }
        continueFlag = false
        presentationMode.wrappedValue.dismiss()
      } catch {
        status = -2
      }
    } while(continueFlag)
  }
}
