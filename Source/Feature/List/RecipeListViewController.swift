//
//  RecipeListViewController
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Show a list of recipes
final class RecipeListViewController: UIViewController {

  /// When a recipe get select
  var select: ((Recipe) -> Void)?

  private var collectionView: UICollectionView!
  private var refreshControl = UIRefreshControl()
  private let adapter = Adapter<Recipe, RecipeCell>()
  private let recipesService: RecipesService

  // MARK: - Init

  required init(recipesService: RecipesService) {
    self.recipesService = recipesService
    super.init(nibName: nil, bundle: nil)
    self.title = "Recipes"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    loadData()
  }

  private func setup() {
    view.backgroundColor = .white

    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = adapter
    collectionView.delegate = adapter
    collectionView.register(cellType: RecipeCell.self)
    collectionView.backgroundColor = Color.background
    collectionView.contentInset.top = 8

    adapter.select = select
    adapter.configure = { recipe, cell in
      cell.imageView.setImage(url: recipe.imageUrl)
      cell.label.text = recipe.title
    }

    view.addSubview(collectionView)
    NSLayoutConstraint.pin(view: collectionView, toEdgesOf: view)

    collectionView.addSubview(refreshControl)
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }

  @objc private func refresh() {
    loadData()
  }

  private func loadData() {
    refreshControl.beginRefreshing()
    recipesService.fetchTopRating(completion: { [weak self] recipes in
      self?.adapter.items = recipes
      self?.collectionView.reloadData()
      self?.refreshControl.endRefreshing()
    })
  }
}
