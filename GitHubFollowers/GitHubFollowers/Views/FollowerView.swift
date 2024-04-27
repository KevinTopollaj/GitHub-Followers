//
//  FollowerView.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import SwiftUI

struct FollowerView: View {

  var follower: Follower

  var body: some View {

    VStack {

      AsyncImage(url: URL(string: follower.avatarUrl)) { image in

        image
          .resizable()
          .aspectRatio(contentMode: .fit)

      } placeholder: {

        Image(.avatarPlaceholder)
          .resizable()
          .aspectRatio(contentMode: .fit)
      }
      .clipShape(Circle())

      Text(follower.login)
        .bold()
        .lineLimit(1)
        .minimumScaleFactor(0.6)

    }


  }
}

#Preview {
  FollowerView(follower: Follower(login: "Kevin Topollaj", avatarUrl: ""))
}
