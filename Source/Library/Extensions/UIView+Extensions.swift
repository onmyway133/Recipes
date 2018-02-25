//
//  UIView+Extensions.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

extension UIView {

  /// Convenient method to add a list of subviews
  func addSubviews(_ views: [UIView]) {
    views.forEach({
      addSubview($0)
    })
  }
}
