//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

extension UITableView {

  func reloadDataOnMainThread() {

    DispatchQueue.main.async {
      self.reloadData()
    }
    
  }

  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
  
}
