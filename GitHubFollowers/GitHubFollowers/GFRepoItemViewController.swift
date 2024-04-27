//
//  GFRepoItemViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: AnyObject {

  func didTapGitHubProfile(for user: User)

}

final class GFRepoItemViewController: GFItemInfoViewController {

  // MARK: - Properties -

  weak var delegate: GFRepoItemViewControllerDelegate!

  // MARK: - Init -

  init(user: User, delegate: GFRepoItemViewControllerDelegate) {
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
    itemInfoViewOne.setItemInfo(for: .repos, withCount: user.publicRepos)
    itemInfoViewTwo.setItemInfo(for: .gists, withCount: user.publicGists)
    actionButton.setButton(color: UIColor.systemIndigo,
                           title: "GitHub Profile", 
                           systemImageName: "person.circle")
  }

  // MARK: - Action -

  override func actionButtonTapped() {
    delegate.didTapGitHubProfile(for: user)
  }
}
