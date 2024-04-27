//
//  OnboardingView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import SwiftUI

struct OnboardingView: View {

  var searchAction: () -> Void

  var body: some View {

    TabView {

      VStack {
        ResizedImageView(imageName: "avatar-placeholder")
          .tag(0)

        Text("Welcome to GitHub Followers")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundStyle(.indigo)
      }

      VStack {
        ResizedImageView(imageName: "avatar-placeholder")
          .tag(1)

        Text("Search GitHub Followers")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundStyle(.indigo)
      }

      VStack {
        ResizedImageView(imageName: "avatar-placeholder")
          .tag(2)

        Button("Start Searching") {
          searchAction()
        }
        .foregroundStyle(.black)
        .background(Color.indigo)
        .buttonStyle(.bordered)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      }
      
    }
    .tabViewStyle(.page)
    .background(Color.black.ignoresSafeArea())

  }
}

#Preview {
  OnboardingView(searchAction: {})
}
