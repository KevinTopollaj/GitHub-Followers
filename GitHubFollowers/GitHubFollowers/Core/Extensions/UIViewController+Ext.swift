//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit
import SafariServices

extension UIViewController {

  func presentGFAlert(title: String, message: String, buttonTitle: String) {

    let alertViewController = GFAlertViewController(alertTitle: title,
                                                    alertMessage: message,
                                                    buttonTitle: buttonTitle)
    alertViewController.modalPresentationStyle = .overFullScreen
    alertViewController.modalTransitionStyle = .crossDissolve
    present(alertViewController, animated: true)
  }

  func presentDefaultError() {

    let alertViewController = GFAlertViewController(alertTitle: "Something went wrong", alertMessage: "We are unable to complete your task at this time. Please try again. ", buttonTitle: "Ok")
    alertViewController.modalPresentationStyle = .overFullScreen
    alertViewController.modalTransitionStyle = .crossDissolve
    present(alertViewController, animated: true)
  }

  func presentSafariViewController(with url: URL) {
    let safariViewController = SFSafariViewController(url: url)
    safariViewController.preferredControlTintColor = .systemIndigo
    present(safariViewController, animated: true)
  }

}
