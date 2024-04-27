//
//  GridLayout.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

enum GridLayout {
  
  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {

    let width = view.bounds.width
    let padding: CGFloat = 12
    let innerItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - (innerItemSpacing * 2)
    let itemWidth = availableWidth / 3

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding,
                                           bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    return flowLayout

  }

}
