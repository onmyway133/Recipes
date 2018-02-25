//
//  SearchComponent.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// A reusable component to add search functionality via search bar
final class SearchComponent: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
  let recipesService: RecipesService
  let searchController: UISearchController
  let recipeListViewController = RecipeListViewController()
  var task: URLSessionTask?

  required init(recipesService: RecipesService) {
    self.recipesService = recipesService
    self.searchController = UISearchController(searchResultsController: recipeListViewController)
    super.init()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.dimsBackgroundDuringPresentation = true
  }

  func add(to viewController: UIViewController) {
    if #available(iOS 11, *) {
      viewController.navigationItem.searchController = searchController
    } else {
      viewController.navigationItem.titleView = searchController.searchBar
    }
  }

  // MARK: - UISearchResultsUpdating

  func updateSearchResults(for searchController: UISearchController) {
    // No op
  }

  // MARK: - UISearchBarDelegate

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    search(query: searchText)
  }

  // MARK: - Logic

  private func search(query: String) {
    task?.cancel()
    task = recipesService.search(query: query, completion: { [weak self] recipes in
      self?.recipeListViewController.handle(recipes: recipes)
    })
  }
}
