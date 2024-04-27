//
//  OnboardingCoordinator.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import Combine
import SwiftUI

class OnboardingCoordinator: Coordinator {

  var rootViewController = UIViewController()

  var hasFinishedOnboarding: CurrentValueSubject<Bool, Never>

  init(hasFinishedOnboarding: CurrentValueSubject<Bool, Never>) {
    self.hasFinishedOnboarding = hasFinishedOnboarding
  }

  func start() {
    
    let onboardingView = OnboardingView { [weak self] in

      guard let self else { return }
      self.hasFinishedOnboarding.send(true)

    }

    rootViewController = UIHostingController(rootView: onboardingView)
  }

}
