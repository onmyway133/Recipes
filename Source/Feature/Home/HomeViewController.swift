//
//  HomeViewController.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Show a list of recipes
final class HomeViewController: UIViewController {

  /// When a recipe get select
  var select: ((Recipe) -> Void)?

  private var refreshControl = UIRefreshControl()
  private let recipesService: RecipesService
  private let searchComponent: SearchComponent
  private let recipeListViewController = RecipeListViewController()

  // MARK: - Init

  required init(recipesService: RecipesService) {
    self.recipesService = recipesService
    self.searchComponent = SearchComponent(recipesService: recipesService)
    super.init(nibName: nil, bundle: nil)
    self.title = "Recipes"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - View life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupSearch()
    loadData()
  }

  // MARK: - Setup

  private func setup() {
    recipeListViewController.adapter.select = select
    add(childViewController: recipeListViewController)
    recipeListViewController.collectionView.addSubview(refreshControl)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }

  private func setupSearch() {
    searchComponent.add(to: self)
    searchComponent.recipeListViewController.adapter.select = select
  }

  // MARK: - Action

  @objc private func refresh() {
    loadData()
  }

  // MARK: - Data

  private func loadData() {
    refreshControl.beginRefreshing()
    recipesService.fetchTopRating(completion: { [weak self] recipes in
      self?.recipeListViewController.handle(recipes: recipes)
      self?.refreshControl.endRefreshing()
    })
  }
}
