//
//  RecipeFlowController.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Manage list and detail screens for recipe
final class RecipeFlowController: UINavigationController {

  /// Start the flow
  func start() {
    let controller = RecipeListViewController()
    viewControllers = [controller]
    controller.select = { [weak self] recipe in
      self?.startDetail(recipe: recipe)
    }
  }

  private func startDetail(recipe: Recipe) {
    let controller = RecipeDetailViewController(recipe: recipe)
    pushViewController(controller, animated: true)
  }
}
