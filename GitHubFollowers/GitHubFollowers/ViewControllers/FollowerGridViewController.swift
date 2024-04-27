//
//  FollowerGridViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class FollowerGridViewController: GFDataLoadingViewController {

  // MARK: - Sections -

  enum Section {
    case main
  }

  // MARK: - Properties -

  var userName: String!
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []

  var page = 1
  var hasMoreFollowers = true
  var isSearching = false
  var isLoadingMoreFollowers = false

  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

  var coordinator: Coordinator

  // MARK: - Initializer -

  init(coordinator: Coordinator, userName: String) {

    self.coordinator = coordinator

    super.init(nibName: nil, bundle: nil)

    self.userName = userName
    title = userName
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Elements -

  private lazy var searchController: UISearchController = {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = "Search for a username"
    return searchController
  }()

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configureCollectionView()
    configureDataSource()

    getFollowers(userName: userName, page: page)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(false, animated: true)

  }

  override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {

    if followers.isEmpty && !isLoadingMoreFollowers {

      var config = UIContentUnavailableConfiguration.empty()
      config.image = .init(systemName: "person.slash")
      config.text = "No Followers"
      config.secondaryText = "This user has no followers!"

      contentUnavailableConfiguration = config

    } else if isSearching && filteredFollowers.isEmpty {

      contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()

    } else {

      contentUnavailableConfiguration = nil

    }

  }

  // MARK: - Helper Methods -

  private func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true

    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
    navigationItem.rightBarButtonItem = addButton
  }

  // MARK: - Action -

  @objc func addButtonAction() {

    showLoadingView()

    Task {

      do {

        let user = try await NetworkManager.shared.getUserInfo(for: userName)
        self.addUserToFavourites(user: user)
        self.dismissLoadingView()

      } catch {

        if let gfError = error as? GFError {
          presentGFAlert(title: "Something went wrong!", message: gfError.rawValue, buttonTitle: "Ok")
        } else {
          presentDefaultError()
        }

        self.dismissLoadingView()

      }

    }

  }

  private func addUserToFavourites(user: User) {

    let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)

    PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in

      guard let self else { return }

      guard let error else {
        DispatchQueue.main.async {
          self.presentGFAlert(title: "Success!", message: "You have added this user to your favourites.", buttonTitle: "Ok")
        }
        return
      }

      DispatchQueue.main.async {
        self.presentGFAlert(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
      }
    }

  }

  // MARK: - Network -

  private func getFollowers(userName: String, page: Int) {

    showLoadingView()
    isLoadingMoreFollowers = true

    Task {

      do {

        let followers = try await NetworkManager.shared.getFollowers(for: userName, page: page)
        self.updateUI(with: followers)
        dismissLoadingView()
        isLoadingMoreFollowers = false

      } catch {

        if let gfError = error as? GFError {
          presentGFAlert(title: "Error", message: gfError.rawValue, buttonTitle: "Ok")
        } else {
          presentDefaultError()
        }

        dismissLoadingView()
        isLoadingMoreFollowers = false
      }
    }

  }

  private func updateUI(with followers: [Follower]) {

    if followers.count < 50 { self.hasMoreFollowers = false }
    self.followers.append(contentsOf: followers)

    self.updateData(for: self.followers)

    setNeedsUpdateContentUnavailableConfiguration()

    DispatchQueue.main.async {

      self.updateSearchResults(for: self.searchController)

    }

  }

  private func configureCollectionView() {

    collectionView = UICollectionView(frame: view.bounds,
                                      collectionViewLayout: GridLayout.createThreeColumnFlowLayout(in: view))

    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCollectionViewCell.self,
                            forCellWithReuseIdentifier: FollowerCollectionViewCell.identifier)


  }

  private func configureDataSource() {

    dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, follower in

      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.identifier, for: indexPath) as! FollowerCollectionViewCell
      cell.configure(follower: follower)
      return cell

    }

  }

  private func updateData(for followers: [Follower]) {

    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)

    dataSource.apply(snapshot, animatingDifferences: true)

  }

}

// MARK: - UICollectionViewDelegate -

extension FollowerGridViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let activeArray = isSearching ? filteredFollowers : followers
    let follower = activeArray[indexPath.row]

    if let coordinator = coordinator as? SearchCoordinator {
      coordinator.goToUserProfile(username: follower.login, delegate: self)
    } else if let coordinator = coordinator as? FavoritesCoordinator {
      coordinator.goToUserProfile(username: follower.login, delegate: self)
    }

  }

  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height

    if offsetY > contentHeight - height {
      guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
      page += 1
      getFollowers(userName: userName, page: page)
    }

  }
}

// MARK: - UICollectionViewDelegate -

extension FollowerGridViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    
    guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
      filteredFollowers.removeAll()
      isSearching = false
      updateData(for: followers)
      return
    }

    isSearching = true

    filteredFollowers = followers.filter { $0.login.lowercased().contains(searchText.lowercased()) }
    
    updateData(for: filteredFollowers)

    setNeedsUpdateContentUnavailableConfiguration()
  }

}

// MARK: - FollowerGridViewControllerDelegate -

extension FollowerGridViewController: UserInfoViewControllerDelegate {

  func didRequestFollowers(for username: String) {

    self.userName = username
    title = username

    page = 1

    followers.removeAll()
    filteredFollowers.removeAll()

    // scroll the collection view to the top
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)

    getFollowers(userName: username, page: page)

  }
  
}
