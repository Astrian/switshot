//
//  imageFromVideo.swift
//  star
//
//  Created by Astrian Zheng on 2021/12/1.
//

import UIKit
import AVFoundation

func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
  let asset = AVURLAsset(url: url)

  let assetIG = AVAssetImageGenerator(asset: asset)
  assetIG.appliesPreferredTrackTransform = true
  assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels

  let cmTime = CMTime(seconds: time, preferredTimescale: 60)
  let thumbnailImageRef: CGImage
  do {
    thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
    return UIImage(cgImage: thumbnailImageRef)
  } catch let error {
    print(error)
    return nil
  }
}
