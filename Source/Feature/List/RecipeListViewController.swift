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
  private(set) var collectionView: UICollectionView!
  let adapter = Adapter<Recipe, RecipeCell>()

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
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

    adapter.configure = { recipe, cell in
      cell.imageView.setImage(url: recipe.imageUrl, placeholder: R.image.recipePlaceholder())
      cell.label.text = recipe.title
    }

    view.addSubview(collectionView)
    NSLayoutConstraint.pin(view: collectionView, toEdgesOf: view)
  }

  func handle(recipes: [Recipe]) {
    adapter.items = recipes
    collectionView.reloadData()
  }
}
