//
//  saveVideo.swift
//  star
//
//  Created by Astrian Zheng on 2021/12/3.
//

import Foundation
import Photos

func saveVideo(_ videoUuid: UUID) {
  let path = (FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.astrianzheng.star"))!.path
  PHPhotoLibrary.shared().performChanges({
    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: "\(path)/media/\(videoUuid.uuidString).mp4"))
  }) { saved, error in }
}
