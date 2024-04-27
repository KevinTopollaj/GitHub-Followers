//
//  GFAlertViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

final class GFAlertViewController: UIViewController {

  // MARK: - Properties -

  var alertTitle: String?
  var alertMessage: String?
  var buttonTitle: String?

  private let padding: CGFloat = 20

  // MARK: - UI Elements -

  private lazy var containerView: GFAlertContentView = {
    let view = GFAlertContentView()
    return view
  }()

  private lazy var titleLabel: GFTitleLabel = {
    let label = GFTitleLabel(textAlignment: .center, fontSize: 20)
    label.text = alertTitle ?? "Something went wrong"
    return label
  }()

  private lazy var messageLabel: GFBodyLabel = {
    let label = GFBodyLabel(textAlignment: .center)
    label.text = alertMessage ?? "Unable to complete request"
    label.numberOfLines = 4
    return label
  }()

  private lazy var actionButton: GFButton = {
    let button = GFButton(color: .systemIndigo, title: buttonTitle ?? "Ok", systemImageName: "checkmark.circle")
    button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    return button
  }()

  // MARK: - Initializers -

  init(alertTitle: String, alertMessage: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = alertTitle
    self.alertMessage = alertMessage
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)

    addSubviewAndLayout()
  }

  // MARK: - Actions -

  @objc func dismissAlert() {
    self.dismiss(animated: true)
  }

  // MARK: - Subviews and Layout -

  private func addSubviewAndLayout() {

    view.addSubview(containerView)

    containerView.addSubviews(titleLabel, messageLabel, actionButton)

    NSLayoutConstraint.activate([
      // Container View
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220),

      // Title Label
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      titleLabel.heightAnchor.constraint(equalToConstant: 28),

      // Message Label
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12),

      // Action Button
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)

    ])

  }

}
