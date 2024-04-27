//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFBodyLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(textAlignment: NSTextAlignment) {
    self.init(frame: .zero)
    self.textAlignment = textAlignment
  }

  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    font = UIFont.preferredFont(forTextStyle: .body)
    adjustsFontForContentSizeCategory = true
    textColor = .secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.6
    lineBreakMode = .byWordWrapping
  }

}
