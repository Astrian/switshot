//
//  VideoPlayerView.swift
//  VideoPlayerView
//
//  Created by Astrian Zheng on 2021/9/11.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
  @State var url: String
  var body: some View {
    VideoPlayer(player: AVPlayer(url: URL(fileURLWithPath: url)))
      .navigationBarTitleDisplayMode(.inline)
  }
}
