//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Show detail information for a recipe
final class RecipeDetailViewController: BaseController<RecipeDetailView> {
  private let recipe: Recipe
  private let recipesService: RecipesService

  // MARK: - Init

  required init(recipe: Recipe, recipesService: RecipesService) {
    self.recipe = recipe
    self.recipesService = recipesService
    super.init(nibName: nil, bundle: nil)
    self.title = recipe.title
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - Life cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Color.background
    update(recipe: recipe)
    loadData()
  }

  private func update(recipe: Recipe) {
    root.imageView.setImage(url: recipe.imageUrl)

    if let ingredients = recipe.ingredients {
      root.ingredientLabel.text = ingredients.joined(separator: "\n")
    }
  }

  private func loadData() {
    recipesService.fetch(recipeId: recipe.id, completion: { [weak self] recipe in
      if let recipe = recipe {
        self?.update(recipe: recipe)
      }
    })
  }
}
