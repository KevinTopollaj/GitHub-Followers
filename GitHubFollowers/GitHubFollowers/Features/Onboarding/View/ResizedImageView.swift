//
//  ResizedImageView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import SwiftUI

struct ResizedImageView: View {

  let imageName: String

  var body: some View {

    Image(imageName)
      .resizable()
      .scaledToFit()

  }
}

#Preview {
    ResizedImageView(imageName: "avatar-placeholder")
}
