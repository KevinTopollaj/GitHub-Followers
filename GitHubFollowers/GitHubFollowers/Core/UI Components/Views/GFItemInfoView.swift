//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

enum ItemInfoType {
  case repos, gists, following, followers
}

final class GFItemInfoView: UIView {

  // MARK: - UI Elements -

  private lazy var symbolImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.tintColor = UIColor.systemIndigo
    return imageView
  }()

  private lazy var titleLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .left, fontSize: 14)

    return label
  }()

  private lazy var countLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .left, fontSize: 14)
    label.textAlignment = .center
    return label
  }()

  // MARK: - Initializer -

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Helper Methods -

  private func addSubviewAndLayout() {

    addSubviews(symbolImageView, titleLabel, countLabel)

    NSLayoutConstraint.activate([
      
      symbolImageView.topAnchor.constraint(equalTo: topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      symbolImageView.heightAnchor.constraint(equalToConstant: 20),
      symbolImageView.widthAnchor.constraint(equalToConstant: 20),

      titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: 18),

      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 18)
    ])

  }

  func setItemInfo(for itemInfoType: ItemInfoType, withCount count: Int) {

    switch itemInfoType {
    case .repos:
      symbolImageView.image = SFSymbols.repos
      titleLabel.text = "Public Repos"
    case .gists:
      symbolImageView.image = SFSymbols.gists
      titleLabel.text = "Public Gists"
    case .following:
      symbolImageView.image = SFSymbols.following
      titleLabel.text = "Following"
    case .followers:
      symbolImageView.image = SFSymbols.followers
      titleLabel.text = "Followers"
    }

    countLabel.text = String(count)
  }

}
