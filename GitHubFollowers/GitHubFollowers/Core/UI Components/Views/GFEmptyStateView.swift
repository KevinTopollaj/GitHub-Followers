//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFEmptyStateView: UIView {

  // MARK: - UI -

  private lazy var messageLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .center, fontSize: 24)
    label.numberOfLines = 3
    label.textColor = .secondaryLabel
    return label
  }()

  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Images.emptyStateLogo
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // MARK: - Initializers -

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  convenience init(message: String) {
    self.init(frame: .zero)

    messageLabel.text = message
  }

  // MARK: - Helper Methods -

  private func addSubviewAndLayout() {

    addSubviews(messageLabel, logoImageView)

    let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150

    let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 50

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstant),
      messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      messageLabel.heightAnchor.constraint(equalToConstant: 200),

      logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 180),
      logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: logoBottomConstant)
    ])
  }


}
