//
//  GFUserInfoHeaderViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFUserInfoHeaderViewController: UIViewController {

  // MARK: - Properties -

  var user: User

  // MARK: - Initializer -

  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - UI -

  private lazy var avatarImageView: GFAvatarImageView = {
    let imageView = GFAvatarImageView(frame: .zero)
    imageView.downloadImage(from: user.avatarUrl)
    return imageView
  }()

  private lazy var userNameLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .left, fontSize: 30)
    label.text = user.login
    return label
  }()

  private lazy var nameLabel: GFSecondaryTitleLabel = {
    let label = GFSecondaryTitleLabel(fontSize: 18)
    label.text = user.name ?? ""
    return label
  }()

  private lazy var locationImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = SFSymbols.location
    imageView.tintColor = .secondaryLabel
    return imageView
  }()

  private lazy var locationLabel: GFSecondaryTitleLabel = {
    let label = GFSecondaryTitleLabel(fontSize: 18)
    label.text = user.location ?? "No Location"
    return label
  }()

  private lazy var bioLabel: GFBodyLabel = {
    let label = GFBodyLabel(textAlignment: .left)
    label.text = user.bio ?? "No Bio available"
    label.numberOfLines = 3
    return label
  }()

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    addSubviewAndLayout()
  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    view.addSubviews(avatarImageView, userNameLabel, nameLabel, locationImageView, locationLabel, bioLabel)

    let padding: CGFloat = 20
    let textImagePadding: CGFloat = 12

    NSLayoutConstraint.activate([
      
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      avatarImageView.widthAnchor.constraint(equalToConstant: 90),
      avatarImageView.heightAnchor.constraint(equalToConstant: 90),

      userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      userNameLabel.heightAnchor.constraint(equalToConstant: 34),

      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),

      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
      locationImageView.heightAnchor.constraint(equalToConstant: 20),
      locationImageView.widthAnchor.constraint(equalToConstant: 20),

      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      locationLabel.heightAnchor.constraint(equalToConstant: 20),

      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bioLabel.heightAnchor.constraint(equalToConstant: 90)
    ])

  }

}
