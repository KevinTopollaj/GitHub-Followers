//
//  FollowerGridPresentable.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

protocol FollowerGridPresentable: AnyObject {

  var rootViewController: UINavigationController { get set }

  func goToFollowerGrid(coordinator: Coordinator, userName: String)

  func goToUserProfile(username: String, delegate: UserInfoViewControllerDelegate)

}

extension FollowerGridPresentable {

  func goToFollowerGrid(coordinator: Coordinator, userName: String) {

    let followerGridViewController = FollowerGridViewController(coordinator: coordinator, userName: userName)

    rootViewController.pushViewController(followerGridViewController, animated: true)

  }

  func goToUserProfile(username: String, delegate: UserInfoViewControllerDelegate) {

    let userInfoViewController = UserInfoViewController()
    userInfoViewController.username = username
    userInfoViewController.delegate = delegate
    let navigationController = UINavigationController(rootViewController: userInfoViewController)
    rootViewController.present(navigationController, animated: true)

  }

}
