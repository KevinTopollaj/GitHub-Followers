//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import Foundation

extension Date {

  func convertToMonthYearFormat() -> String {
    return formatted(.dateTime.month().year())
  }

}
