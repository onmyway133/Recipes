//
//  UICollectionView+Extensions.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

extension UICollectionView {

  /// Generic function to dequeue cell
  func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
    // swiftlint:disable force_cast
    return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
  }

  /// Generic function to register cell
  func register(cellType: UICollectionViewCell.Type) {
    register(cellType, forCellWithReuseIdentifier: String(describing: cellType.self))
  }
}
