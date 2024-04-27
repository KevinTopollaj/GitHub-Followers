//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFAvatarImageView: UIImageView {

  // MARK: - Properties -

  let cache = NetworkManager.shared.cache

  // MARK: - Initializer -

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure -
  
  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = Images.avatarPlaceHolder
    translatesAutoresizingMaskIntoConstraints = false
  }

  // MARK: - Download Image -

  func downloadImage(from urlString: String) {

    Task {

      image = await NetworkManager.shared.downloadImage(from: urlString) ?? Images.avatarPlaceHolder

    }

  }

}
