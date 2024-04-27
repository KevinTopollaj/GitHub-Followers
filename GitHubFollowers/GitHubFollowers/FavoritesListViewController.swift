//
//  FavoritesListViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {

  // MARK: - Properties -

  var favourites: [Follower] = []
  var coordinator: FavoritesCoordinator

  // MARK: - UI Elements -

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 80
    tableView.register(FavoriteListTableViewCell.self,
                       forCellReuseIdentifier: FavoriteListTableViewCell.identifier)
    tableView.removeExcessCells()
    return tableView
  }()

  // MARK: - Initializer -

  init(coordinator: FavoritesCoordinator) {
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    addSubviewAndLayout()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    getFavourites()

  }

  override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {

    if favourites.isEmpty {

      var config = UIContentUnavailableConfiguration.empty()
      config.image = .init(systemName: "star")
      config.text = "No Favorites"
      config.secondaryText = "Add a favorite on the follower screen."

      contentUnavailableConfiguration = config

    } else {

      contentUnavailableConfiguration = nil

    }

  }

  // MARK: - Helper Methods -

  private func configureViewController() {
    view.backgroundColor = .systemBackground
  }

  private func getFavourites() {

    PersistenceManager.retrieveFavourites { [weak self] result in

      guard let self else { return }

      switch result {

      case .success(let favourites):
        
        self.updateUI(with: favourites)

      case .failure(let error):

        DispatchQueue.main.async {
          self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }

      }

    }

  }

  private func updateUI(with favourites: [Follower]) {

    self.favourites = favourites

    setNeedsUpdateContentUnavailableConfiguration()

    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.view.bringSubviewToFront(self.tableView)
    }

  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    view.addSubview(tableView)
    tableView.frame = view.bounds

  }

}

// MARK: - UITableViewDataSource -

extension FavoritesListViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    favourites.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let favourite = favourites[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListTableViewCell.identifier, for: indexPath) as! FavoriteListTableViewCell
    cell.configure(favourite: favourite)
    return cell

  }

}

// MARK: - UITableViewDelegate -

extension FavoritesListViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let favourite = favourites[indexPath.row]

    coordinator.goToFollowerGrid(coordinator: coordinator, userName: favourite.login)

  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

    guard editingStyle == .delete else { return }

    let favourite = favourites[indexPath.row]

    PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in

      guard let self else { return }

      guard let error = error else {

        self.favourites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)

        setNeedsUpdateContentUnavailableConfiguration()

        return
      }

      DispatchQueue.main.async {
        self.presentGFAlert(title: "Unable to remove user from favourites.", message: error.rawValue, buttonTitle: "Ok")
      }

    }
  }

}

#Preview {

  return FavoritesListViewController(coordinator: FavoritesCoordinator())

}
