//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

extension UIView {

  func pinToEdges(of superview: UIView) {

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor),
    ])

  }

  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }

}
