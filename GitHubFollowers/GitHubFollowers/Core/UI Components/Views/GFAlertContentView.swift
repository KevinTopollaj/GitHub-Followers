//
//  GFAlertContentView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFAlertContentView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    layer.cornerRadius = 16
    layer.borderWidth = 2
    layer.borderColor = UIColor.white.cgColor
  }

}
