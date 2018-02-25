//
//  ScrollableView.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Vertically layout view using Auto Layout in UIScrollView
final class ScrollableView: UIView {
  private let scrollView = UIScrollView()
  private let contentView = UIView()

  struct Pair {
    let view: UIView
    let inset: UIEdgeInsets
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    scrollView.showsHorizontalScrollIndicator = false
    scrollView.alwaysBounceHorizontal = false
    addSubview(scrollView)

    scrollView.addSubview(contentView)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.leftAnchor.constraint(equalTo: leftAnchor),
      scrollView.rightAnchor.constraint(equalTo: rightAnchor),

      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.leftAnchor.constraint(equalTo: leftAnchor),
      contentView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  func setup(pairs: [Pair]) {
    pairs.enumerated().forEach({ tuple in
      let view = tuple.element.view
      let inset = tuple.element.inset
      let offset = tuple.offset

      scrollView.addSubview(view)

      if offset == 0 {
        NSLayoutConstraint.activate([
          view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset.top)
        ])
      } else {
        NSLayoutConstraint.activate([
          view.topAnchor.constraint(equalTo: pairs[offset - 1].view.bottomAnchor, constant: inset.top)
        ])
      }

      if offset == pairs.count - 1 {
        NSLayoutConstraint.activate([
          view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset.bottom)
        ])
      }

      NSLayoutConstraint.activate([
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: inset.left),
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -inset.right)
      ])
    })
  }
}
