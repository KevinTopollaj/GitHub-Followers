//
//  MainCoordinator.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class MainCoordinator: Coordinator {

  let rootViewController: UITabBarController

  var childCoordinators = [Coordinator]()

  init() {
    UITabBar.appearance().tintColor = .systemIndigo
    self.rootViewController = UITabBarController()
    self.rootViewController.tabBar.isTranslucent = true
  }

  func start() {

    let searchCoordinator = SearchCoordinator()
    searchCoordinator.start()
    self.childCoordinators.append(searchCoordinator)

    let searchViewController = searchCoordinator.rootViewController
    setupTabBarItem(viewController: searchViewController, title: "Search", item: .search, tag: 0)

    let favoritesCoordinator = FavoritesCoordinator()
    favoritesCoordinator.start()
    self.childCoordinators.append(favoritesCoordinator)

    let favouriteListViewController = favoritesCoordinator.rootViewController
    setupTabBarItem(viewController: favouriteListViewController, title: "Favourites", item: .favorites, tag: 1)

    self.rootViewController.viewControllers = [searchViewController, favouriteListViewController]

  }

  private func setupTabBarItem(viewController: UIViewController, title: String, item: UITabBarItem.SystemItem, tag: Int) {
    let tabBarItem = UITabBarItem(tabBarSystemItem: item, tag: tag)
    viewController.title = title
    viewController.tabBarItem = tabBarItem
  }

}
