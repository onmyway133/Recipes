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

  /// Apply mask to round corners
  func round(corners: UIRectCorner) {
    let raddi = bounds.size.height / 2
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: raddi, height: raddi)
    )

    let maskLayer = CAShapeLayer()

    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }
}
