//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Show detail information for a recipe
final class RecipeDetailViewController: UIViewController {
  private let recipe: Recipe

  required init(recipe: Recipe) {
    self.recipe = recipe
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
