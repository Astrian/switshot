//
//  QuickLookComp.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import SwiftUI

struct QuickLookComp: View {
  @State var url: URL
  @Environment(\.presentationMode) private var presentationMode
  var body: some View {
    PreviewController(url: url)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Label("Dismiss", systemImage: "xmark").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          HStack {
            Button(action: {  }) {
              Label("Share", systemImage: "square.and.arrow.up").labelStyle(.titleAndIcon).foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
            Menu {
              Button {} label: {
                Label("Save to Library", systemImage: "square.and.arrow.down")
              }
              Button(role: .destructive) {} label: {
                Label("Delete", systemImage: "trash")
              }
            } label: {
              Image(systemName: "ellipsis.circle").foregroundColor(Color.primary).padding(.horizontal, 18).padding(.vertical, 8).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
          }
        }
      }.ignoresSafeArea()
  }
}
