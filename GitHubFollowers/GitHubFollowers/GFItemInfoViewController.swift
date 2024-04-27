//
//  GFItemInfoViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

protocol GFItemInfoViewControllerDelegate: AnyObject {

  func didTapGitHubProfile(for user: User)
  func didTapGitHubFollowers(for user: User)

}

class GFItemInfoViewController: UIViewController {

  // MARK: - UI Elements -

  lazy var itemInfoViewOne: GFItemInfoView = {
    let item = GFItemInfoView()
    return item
  }()

  lazy var itemInfoViewTwo: GFItemInfoView = {
    let item = GFItemInfoView()
    return item
  }()

  lazy var itemStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [itemInfoViewOne, itemInfoViewTwo])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    return stackView
  }()

  lazy var actionButton: GFButton = {
    let button = GFButton()
    button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    return button
  }()

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
  
  // MARK: - Life Cycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    configureBackgroundView()
    addSubviewAndLayout()
  }

  // MARK: - Action -
  @objc func actionButtonTapped() {
    // will be override
  }

  // MARK: - Helper Methods -

  private func configureBackgroundView() {
    
    view.layer.cornerRadius = 18
    view.backgroundColor = UIColor.secondarySystemBackground

  }


  private func addSubviewAndLayout() {

    view.addSubviews(itemStackView, actionButton)

    let padding: CGFloat = 20

    NSLayoutConstraint.activate([
      itemStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      itemStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      itemStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      itemStackView.heightAnchor.constraint(equalToConstant: 50),

      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
