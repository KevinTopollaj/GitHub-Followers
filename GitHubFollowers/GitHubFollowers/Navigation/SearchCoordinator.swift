//
//  SearchCoordinator.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class SearchCoordinator: Coordinator, FollowerGridPresentable {

  var rootViewController = UINavigationController()

  lazy var searchViewController: SearchViewController = {
    let viewController = SearchViewController(coordinator: self)
    return viewController
  }()

  func start() {
    rootViewController.setViewControllers([searchViewController], animated: false)
  }

}
