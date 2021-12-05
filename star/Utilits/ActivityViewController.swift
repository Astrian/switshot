//
//  ActivityViewController.swift
//  star
//
//  Created by Astrian Zheng on 2021/11/26.
//

import SwiftUI
import LinkPresentation 

struct ActivityViewController: UIViewControllerRepresentable {

  var activityItems: [LinkPresentationItemSource]
  var applicationActivities: [UIActivity]? = nil
  // var metaDatas: [LPLinkMetadata]

  func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
    let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    return controller
  }

  func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
