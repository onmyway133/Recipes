//
//  AppFlowController.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Manage app flow
final class AppFlowController: UIViewController {

  /// Start the flow
  func start() {
    let flowController = RecipeFlowController()
    add(childViewController: flowController)
    flowController.start()
  }
}
