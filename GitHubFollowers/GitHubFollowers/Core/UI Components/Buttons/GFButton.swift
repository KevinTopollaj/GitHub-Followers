//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFButton: UIButton {

  // MARK: - Initializers -

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(color: UIColor, title: String, systemImageName: String) {
    self.init(frame: .zero)

    setButton(color: color, title: title, systemImageName: systemImageName)
  }

  // MARK: - Helper Methods -

  private func configure() {

    configuration = .filled()
    configuration?.cornerStyle = .medium
    
    translatesAutoresizingMaskIntoConstraints = false
  }

  func setButton(color: UIColor, title: String, systemImageName: String) {

    configuration?.baseBackgroundColor = color
    configuration?.baseForegroundColor = .white

    configuration?.title = title

    configuration?.image = UIImage(systemName: systemImageName)
    configuration?.imagePadding = 10
    configuration?.imagePlacement = .trailing

  }

}


#Preview {

  let button = GFButton(color: .red, title: "Set date", systemImageName: "calendar")
  return button

}
