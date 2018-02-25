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

  var selectInstruction: ((URL) -> Void)?
  var selectOriginal: ((URL) -> Void)?

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
    setup()
    update(recipe: recipe)
    loadData()
  }

  private func setup() {
    root.instructionButton.addTarget(self, action: #selector(instructionButtonTouched), for: .touchUpInside)
    root.originalButton.addTarget(self, action: #selector(originalButtonTouched), for: .touchUpInside)
  }

  private func update(recipe: Recipe) {
    root.imageView.setImage(url: recipe.imageUrl, placeholder: R.image.recipePlaceholder())
    root.infoView.leftLabel.text = recipe.publisher
    root.infoView.rightLabel.text = "Social rank: \(Int(recipe.socialRank))"

    if let ingredients = recipe.ingredients {
      let text = ingredients
        .map(({ "🍭 \($0)" }))
        .joined(separator: "\n")

      UIView.transition(
        with: root,
        duration: 0.25,
        options: .transitionCrossDissolve,
        animations: {
          self.root.ingredientLabel.text = text
        },
        completion: nil
      )
    }
  }

  // MARK: - Action

  @objc private func instructionButtonTouched() {
    selectInstruction?(recipe.sourceUrl)
  }

  @objc private func originalButtonTouched() {
    selectOriginal?(recipe.publisherUrl)
  }

  // MARK: - Data

  private func loadData() {
    recipesService.fetch(recipeId: recipe.id, completion: { [weak self] recipe in
      if let recipe = recipe {
        self?.update(recipe: recipe)
      }
    })
  }
}
