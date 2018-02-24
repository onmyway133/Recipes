//
//  UIViewController+Extensions.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

extension UIViewController {
  /// Add child view controller and its view
  func add(childViewController: UIViewController) {
    addChildViewController(childViewController)
    view.addSubview(childViewController.view)
    childViewController.didMove(toParentViewController: self)
  }
}
