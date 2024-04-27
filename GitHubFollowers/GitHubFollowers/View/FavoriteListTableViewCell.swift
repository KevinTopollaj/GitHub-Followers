//
//  FavoriteListCell.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class FavoriteListTableViewCell: UITableViewCell {

  // MARK: - Properties -

  static let identifier = String(describing: FavoriteListTableViewCell.self)
  private let padding: CGFloat = 12

  // MARK: - UI Elements -

  private lazy var avatarImageView: GFAvatarImageView = {
    let imageView = GFAvatarImageView(frame: .zero)
    return imageView
  }()

  private lazy var userNameLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .left, fontSize: 26)
    return label
  }()

  // MARK: - Initializers -

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    addSubviewAndLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods -

  func configure(favourite: Follower) {
    userNameLabel.text = favourite.login
    avatarImageView.downloadImage(from: favourite.avatarUrl)
  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    self.accessoryType = .disclosureIndicator

    addSubviews(avatarImageView, userNameLabel)

    NSLayoutConstraint.activate([

      // Avatar ImageView

      avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
      avatarImageView.widthAnchor.constraint(equalToConstant: 60),
      avatarImageView.heightAnchor.constraint(equalToConstant: 60),

      // UserName Label

      userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
      userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
      userNameLabel.heightAnchor.constraint(equalToConstant: 40)

    ])

  }

}
