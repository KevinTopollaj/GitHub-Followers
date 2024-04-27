//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(fontSize: CGFloat) {
    self.init(frame: .zero)
    self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
  }

  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
  }

}
