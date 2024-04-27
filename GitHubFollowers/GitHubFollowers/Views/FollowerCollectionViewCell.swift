//
//  FollowerCollectionViewCell.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit
import SwiftUI

final class FollowerCollectionViewCell: UICollectionViewCell {

  // MARK: - Properties -

  static let identifier = String(describing: FollowerCollectionViewCell.self)
  private let padding: CGFloat = 8

  // MARK: - UI Elements -

  private lazy var avatarImageView: GFAvatarImageView = {
    let imageView = GFAvatarImageView(frame: .zero)
    return imageView
  }()

  private lazy var userNameLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .center, fontSize: 16)
    return label
  }()

  // MARK: - Initializers -

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods -

  func configure(follower: Follower) {

    if #available(iOS 16.0, *) {
      contentConfiguration = UIHostingConfiguration {
        FollowerView(follower: follower)
      }
    } else {
      avatarImageView.downloadImage(from: follower.avatarUrl)
      userNameLabel.text = follower.login
    }

  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    addSubviews(avatarImageView, userNameLabel)

    NSLayoutConstraint.activate([

      // Avatar ImageView

      avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

      // UserName Label

      userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      userNameLabel.heightAnchor.constraint(equalToConstant: 20)

    ])

  }

}
