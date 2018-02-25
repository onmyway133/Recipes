//
//  ThrottleHandler.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

/// Throttle action, allow action to be performed after some delay
final class ThrottleHandler {
  private let delay: TimeInterval
  private let action: () -> Void

  init(delay: TimeInterval, action: @escaping () -> Void) {
    self.delay = delay
    self.action = action
  }

  /// Trigger the action after some delay
  func trigger() {
    
  }
}
