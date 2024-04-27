//
//  FavoritesCoordinator.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class FavoritesCoordinator: Coordinator, FollowerGridPresentable {

  var rootViewController: UINavigationController

  init() {
    self.rootViewController = UINavigationController()
    self.rootViewController.navigationBar.prefersLargeTitles = true
  }

  lazy var favoritesListViewController: FavoritesListViewController = {
    let viewController = FavoritesListViewController(coordinator: self)
    viewController.title = "Favorites"
    return viewController
  }()

  func start() {
    rootViewController.setViewControllers([favoritesListViewController], animated: false)
  }

}
