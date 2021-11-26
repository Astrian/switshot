//
//  LinkPresentationItemSource.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import Foundation
import LinkPresentation

class LinkPresentationItemSource: NSObject, UIActivityItemSource {
  var linkMetaData: LPLinkMetadata
  var shareData: Any
    
  //Prepare data to share
  func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
    return linkMetaData
  }

  func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
    return shareData
  }
  
  /// Return the data will be shared
  /// - Parameters:
  ///   - activityType: Ex: mail, message, airdrop, etc..
  func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
    return linkMetaData.originalURL
  }
  
  init(linkMetaData: LPLinkMetadata, shareData: Any) {
    self.linkMetaData = linkMetaData
    self.shareData = shareData
  }
}
