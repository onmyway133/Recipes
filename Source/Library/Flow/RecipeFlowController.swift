//
//  RecipeFlowController.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit
import SafariServices

/// Manage list and detail screens for recipe
final class RecipeFlowController: UINavigationController {
  /// Start the flow
  func start() {
    let service = RecipesService(networking: NetworkService())
    let controller = HomeViewController(recipesService: service)
    viewControllers = [controller]
    controller.select = { [weak self] recipe in
      self?.startDetail(recipe: recipe)
    }
  }

  private func startDetail(recipe: Recipe) {
    let service = RecipesService(networking: NetworkService())
    let controller = RecipeDetailViewController(recipe: recipe, recipesService: service)

    controller.selectInstruction = { [weak self] url in
      self?.startWeb(url: url)
    }

    controller.selectOriginal = { [weak self] url in
      self?.startWeb(url: url)
    }

    pushViewController(controller, animated: true)
  }

  private func startWeb(url: URL) {
    let controller = SFSafariViewController(url: url)
    pushViewController(controller, animated: true)
  }
}
