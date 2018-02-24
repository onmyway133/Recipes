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
  private let adapter = Adapter<Recipe, RecipeCell>()

  // MARK: - Init

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = adapter
    collectionView.delegate = adapter

    adapter.select = select
    adapter.configure = { recipe, cell in
      cell.imageView.setImage(url: recipe.imageUrl)
      cell.label.text = recipe.title
    }

    view.addSubview(collectionView)
    NSLayoutConstraint.pin(view: collectionView, toEdgesOf: view)
  }
}
