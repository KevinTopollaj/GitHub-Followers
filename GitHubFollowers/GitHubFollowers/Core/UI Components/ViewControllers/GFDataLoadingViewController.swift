//
//  GFDataLoadingViewController.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class GFDataLoadingViewController: UIViewController {

  // MARK: - Properties -

  var containerView: UIView!

  // MARK: - Helper Methods -

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)

    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0

    UIView.animate(withDuration: 0.3) {
      self.containerView.alpha = 0.8
    }

    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    containerView.addSubview(activityIndicator)

    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])

    activityIndicator.startAnimating()

  }

  func dismissLoadingView() {

    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }

  }

  func showEmptyStateView(message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }


}
