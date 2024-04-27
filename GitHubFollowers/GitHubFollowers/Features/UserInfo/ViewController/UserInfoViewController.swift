//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
  func didRequestFollowers(for username: String)
}

final class UserInfoViewController: UIViewController {

  // MARK: - Properties -
  
  var username: String!
  weak var delegate: UserInfoViewControllerDelegate!

  // MARK: - UI -

  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()

  private lazy var contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var headerView: UIView = {
    let view = UIView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var itemViewOne: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var itemViewTwo: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var dateLabel: GFBodyLabel = {
    let label = GFBodyLabel(textAlignment: .center)
    return label
  }()

  var itemViews = [UIView]()

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    configureNavigation()

    addSubviewAndLayout()

    getUserInfo()
  }

  // MARK: - Network -

  private func getUserInfo() {

    Task {

      do {

        let user = try await NetworkManager.shared.getUserInfo(for: username)
        self.configureUIElements(with: user)

      } catch {

        if let gfError = error as? GFError {
          presentGFAlert(title: "Something went wrong!", message: gfError.rawValue, buttonTitle: "Ok")
        } else {
          presentDefaultError()
        }

      }

    }

  }

  // MARK: - Helper Methods -

  private func configureNavigation() {

    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))

    navigationItem.rightBarButtonItem = doneButton

  }

  private func configureUIElements(with user: User) {

    let userInfoHeaderViewController = GFUserInfoHeaderViewController(user: user)
    self.add(childViewController: userInfoHeaderViewController, to: self.headerView)

    let repoItemViewController = GFRepoItemViewController(user: user, delegate: self)
    self.add(childViewController: repoItemViewController, to: self.itemViewOne)

    let followerItemViewController = GFFollowerItemViewController(user: user, delegate: self)
    self.add(childViewController: followerItemViewController, to: self.itemViewTwo)
    
    self.dateLabel.text = "GitHub since: \(user.createdAt.convertToMonthYearFormat())"

  }

  private func add(childViewController: UIViewController, to containerView: UIView) {
    addChild(childViewController)
    containerView.addSubview(childViewController.view)
    childViewController.view.frame = containerView.bounds
    childViewController.didMove(toParent: self)
  }

  // MARK: - Action -

  @objc func doneAction() {
    self.dismiss(animated: true)
  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    view.addSubview(scrollView)
    scrollView.addSubview(contentView)

    itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]

    for itemView in itemViews {
      contentView.addSubview(itemView)
    }

    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140

    scrollView.pinToEdges(of: view)
    contentView.pinToEdges(of: scrollView)

    NSLayoutConstraint.activate([

      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

      headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      headerView.heightAnchor.constraint(equalToConstant: 210),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      itemViewOne.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      itemViewTwo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
      dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 44),
      dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    ])
  }
}

// MARK: - GFRepoItemViewControllerDelegate -

extension UserInfoViewController: GFRepoItemViewControllerDelegate {

  func didTapGitHubProfile(for user: User) {

    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlert(title: "Invalid URL!", message: "The user profile url is invalid.", buttonTitle: "Ok")
      return
    }

    presentSafariViewController(with: url)

  }

}

// MARK: - GFFollowerItemViewControllerDelegate -

extension UserInfoViewController: GFFollowerItemViewControllerDelegate {

  func didTapGitHubFollowers(for user: User) {

    guard user.followers != 0 else {
      presentGFAlert(title: "No followers found!", message: "This user has no followers.", buttonTitle: "Ok")
      return
    }

    delegate.didRequestFollowers(for: user.login)
    
    self.dismiss(animated: true)
  }

}
