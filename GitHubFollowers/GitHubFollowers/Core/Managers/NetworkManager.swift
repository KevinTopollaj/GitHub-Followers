//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import UIKit

class NetworkManager {

  // MARK: - Properties -

  static let shared = NetworkManager()

  private let baseURL = "https://api.github.com"

  let cache = NSCache<NSString, UIImage>()

  let decoder = JSONDecoder()

  // MARK: - Initializer -

  private init() { 
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
  }

  // MARK: - Helper Methods -

  func getFollowers(for userName: String, page: Int) async throws -> [Follower] {

    let endpoint = baseURL + "/users/\(userName)/followers?per_page=50&page=\(page)"

    guard let url = URL(string: endpoint) else {
      throw GFError.invalidUserName
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw GFError.invalidResponse
    }

    do {
      return try decoder.decode([Follower].self, from: data)
    } catch {
      throw GFError.invalidData
    }

  }


  func getUserInfo(for userName: String) async throws -> User {

    let endpoint = baseURL + "/users/\(userName)"

    guard let url = URL(string: endpoint) else {
      throw GFError.invalidUserName
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw GFError.invalidResponse
    }

    do {
      return try decoder.decode(User.self, from: data)
    } catch {
      throw GFError.invalidData
    }

  }


  func downloadImage(from urlString: String) async -> UIImage? {

    let cacheKey = NSString(string: urlString)

    if let image = cache.object(forKey: cacheKey) {
      return image
    }

    guard let url = URL(string: urlString) else { return nil }

    do {

      let (data, _) = try await URLSession.shared.data(from: url)
      guard let image = UIImage(data: data) else { return nil }
      self.cache.setObject(image, forKey: cacheKey)
      return image

    } catch {

      return nil
      
    }

  }

}
