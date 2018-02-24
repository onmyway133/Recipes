//
//  NSLayoutConstraint+Extensions.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  /// Activate constraints
  ///
  /// - Parameter constraints: An array of constraints
  static func activate(_ constraints: [NSLayoutConstraint]) {
    constraints.forEach {
      ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
      $0.isActive = true
    }
  }

  static func pin(view: UIView, toEdgesOf anotherView: UIView) {
    activate([
      view.topAnchor.constraint(equalTo: anotherView.topAnchor),
      view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
      view.rightAnchor.constraint(equalTo: anotherView.rightAnchor),
      view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor)
    ])
  }
}
