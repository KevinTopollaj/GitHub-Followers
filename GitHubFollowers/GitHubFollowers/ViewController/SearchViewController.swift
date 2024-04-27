//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class SearchViewController: UIViewController {

  // MARK: - UI Elements -

  private lazy var logoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = Images.ghLogo
    return imageView
  }()

  private lazy var userNameTextField: GFTextField = {
    let textField = GFTextField()
    textField.delegate = self
    return textField
  }()

  private lazy var getFollowersButton: GFButton = {
    let button = GFButton(color: .systemIndigo, title: "Get Followers", systemImageName: "person.2.circle")
    button.addTarget(self,
                     action: #selector(pushFollowerGridViewController),
                     for: .touchUpInside)
    return button
  }()

  // MARK: - Properties -

  let coordinator: SearchCoordinator

  var isUsernameEmpty: Bool {
    return !userNameTextField.text!.isEmpty
  }

  // MARK: - Initialiser -

  init(coordinator: SearchCoordinator) {
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    addSubviewsAndLayout()
    createDismissKeyboardTapGesture()
    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(true, animated: true)
  }

  // MARK: - Helper Methods -

  private func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
    view.addGestureRecognizer(tap)
  }

  // MARK: - Actions -

  @objc private func pushFollowerGridViewController() {

    guard isUsernameEmpty else {
      presentGFAlert(title: "Empty Username",
                     message: "Please enter a username in order to search for a Github user. 😃",
                     buttonTitle: "Ok")
      return
    }

    userNameTextField.resignFirstResponder()

    coordinator.goToFollowerGrid(coordinator: coordinator, userName: userNameTextField.text!)
  }

  // MARK: - Subviews and layout -

  private func addSubviewsAndLayout() {

    view.addSubviews(logoImageView, userNameTextField, getFollowersButton)

    let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

    NSLayoutConstraint.activate([
      // Logo Image View
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.widthAnchor.constraint(equalToConstant: 200),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),

      // UserName Text Field
      userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
      userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      userNameTextField.heightAnchor.constraint(equalToConstant: 50),

      // Get Followers Button
      getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
    ])

  }
}

// MARK: - UITextFieldDelegate -

extension SearchViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerGridViewController()
    return true
  }

}


#Preview {

  SearchViewController(coordinator: SearchCoordinator())

}
