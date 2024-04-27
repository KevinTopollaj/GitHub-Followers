//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import Foundation

enum GFError: String, Error {
  case invalidUserName = "This username is invalid, please try again."
  case unableToComplete = "Unable to complete your request."
  case invalidResponse = "Invalid response from the server please try again."
  case invalidData = "The data received from the server is invalid please try again."

  case unableToFavourite = "There was an error trying to add this user to favourites, please try again."
  case alreadyInFavourite = "You have already added this user to your favourites."
}
