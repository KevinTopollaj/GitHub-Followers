//
//  GFFollowerItemViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

protocol GFFollowerItemViewControllerDelegate: AnyObject {

  func didTapGitHubFollowers(for user: User)

}

final class GFFollowerItemViewController: GFItemInfoViewController {

  // MARK: - Properties -

  weak var delegate: GFFollowerItemViewControllerDelegate!

  // MARK: - Init -

  init(user: User, delegate: GFFollowerItemViewControllerDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    configureItems()

  }

  // MARK: - Helper Methods -

  private func configureItems() {
    itemInfoViewOne.setItemInfo(for: .followers, withCount: user.followers)
    itemInfoViewTwo.setItemInfo(for: .following, withCount: user.following)
    actionButton.setButton(color: UIColor.systemIndigo, 
                           title: "GitHub Followers",
                           systemImageName: "person.2.circle")
  }

  // MARK: - Action -

  override func actionButtonTapped() {
    delegate.didTapGitHubFollowers(for: user)
  }
}
