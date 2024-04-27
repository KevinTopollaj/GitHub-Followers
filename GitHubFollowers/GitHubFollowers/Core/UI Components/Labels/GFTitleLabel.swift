//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
  }

  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    textColor = .label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.8
    lineBreakMode = .byTruncatingTail
  }
  
}
