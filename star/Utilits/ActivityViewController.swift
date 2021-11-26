//
//  ActivityViewController.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import SwiftUI
import LinkPresentation 

struct ActivityViewController: UIViewControllerRepresentable {

  var activityItems: [Any]
  var applicationActivities: [UIActivity]? = nil
  var metaDatas: [LPLinkMetadata]

  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
    var sharedItems = [LinkPresentationItemSource]()
    for i in (0 ..< activityItems.count) {
      sharedItems.append(LinkPresentationItemSource(linkMetaData: metaDatas[i], shareData: activityItems[i]))
    }
    let controller = UIActivityViewController(activityItems: sharedItems, applicationActivities: applicationActivities)
    // controller.meta
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
