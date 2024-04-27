//
//  AppCoordinator.swift
//  GitHubFollowers
//
//  Created by Kevin Topollaj.
//

import SwiftUI
import UIKit
import Combine

class AppCoordinator: Coordinator {

  let window: UIWindow

  var childCoordinators = [Coordinator]()

  var subscriptions = Set<AnyCancellable>()
  let hasFinishedOnboarding = CurrentValueSubject<Bool, Never>(false)

  init(window: UIWindow) {
    self.window = window

  }

  func start() {

    loadOnboardingValue()

    hasFinishedOnboarding
      .removeDuplicates()
      .sink { [weak self] isFinished in

      guard let self else { return }

      if isFinished {

        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinators = [mainCoordinator]

        self.window.rootViewController = mainCoordinator.rootViewController

      } else {

        let onboardingCoordinator = OnboardingCoordinator(hasFinishedOnboarding: self.hasFinishedOnboarding)
        onboardingCoordinator.start()
        self.childCoordinators = [onboardingCoordinator]
        
        self.window.rootViewController = onboardingCoordinator.rootViewController

      }

    }
    .store(in: &subscriptions)

  }

  private func loadOnboardingValue() {

    let key = "hasFinishedOnboarding"
    // by default it is `false`
    let value = UserDefaults.standard.bool(forKey: key)
    hasFinishedOnboarding.send(value)

    hasFinishedOnboarding
    // save if `true`
      .filter({ $0 })
      .sink { value in

        UserDefaults.standard.setValue(value, forKey: key)

      }
      .store(in: &subscriptions)

  }

}
