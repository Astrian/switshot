//
//  QRScannerComp.swift
//  star
//
//  Created by Astrian Zheng on 2022/1/20.
//

import SwiftUI
import CodeScanner

struct QRScannerComp: View {
  @Environment(\.presentationMode) private var presentationMode
  @State var status = 0
  
  var body: some View {
    NavigationView {
      VStack(spacing: 40) {
        if (status == 0) {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Scanning_Title").font(.title).bold()
            Text("HomeView_QRScannerComp_Scanning_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
          }
          CodeScannerView(codeTypes: [.qr]) { response in
            switch response {
            case .success(let result):
              scanResProcess(res: result.string)
            case .failure(let error):
              print(error.localizedDescription)
            }
          }.frame(width: 300, height: 200).cornerRadius(8)
          
          Spacer()
        } else if (status == -1) {
          Spacer().frame(height: 20)
          VStack(spacing: 10) {
            Text("HomeView_QRScannerComp_Scanning_Alert_Title").font(.title).bold()
            Text("HomeView_QRScannerComp_Scanning_Alert_Desc").foregroundColor(.gray).multilineTextAlignment(.center)
            Link(destination: URL(string: NSLocalizedString("HomeView_ConnectionComp_Error_HelpBtn_Link", comment: ""))!) {
              Text("HomeView_QRScannerComp_Scanning_Alert_HelpBtn")
            }
          }
          Spacer()
          Button(action: { status = 0 }) {
            HStack {
              Spacer()
              Text("返回扫码").bold().foregroundColor(.black.opacity(0.9))
              Spacer()
            }.frame(height: 50).background(.gray.opacity(0.2)).cornerRadius(8)
          }
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
  
  func scanResProcess(res: String) {
    do {
      let verifyQRRegex = try NSRegularExpression(pattern: "^WIFI:S:switch_([A-Z]|[a-z]|[0-9]){11};T:WPA;P:([a-z]|[0-9]){8};;$")
      if (verifyQRRegex.matches(in: res, range: NSRange(location: 0, length: res.count)).count == 1) {
        print("ok")
      } else {
        status = -1
      }
    } catch {
      print("error")
    }
  }
}
