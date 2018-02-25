//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

final class RecipeDetailView: UIView {
  private let scrollableView = ScrollableView()
  private(set) lazy var imageView: UIImageView = self.makeImageView()
  private(set) lazy var ingredientLabel: UILabel = self.makeIngredientLabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func setupConstraints() {
    let ingredientHeaderView = HeaderView(text: "Ingredients")
    let infoHeaderView = HeaderView(text: "Info")

    addSubview(scrollableView)
    NSLayoutConstraint.pin(view: scrollableView, toEdgesOf: self)

    scrollableView.setup(pairs: [
      ScrollableView.Pair(view: imageView, inset: .zero),
      ScrollableView.Pair(view: ingredientHeaderView, inset: .zero),
      ScrollableView.Pair(view: ingredientLabel, inset: .zero),
      ScrollableView.Pair(view: infoHeaderView, inset: .zero)
    ])

    NSLayoutConstraint.activate([
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 9.0/16),

      ingredientHeaderView.heightAnchor.constraint(equalToConstant: 30),
      infoHeaderView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }

  // MARK: - Make

  private func makeImageView() -> UIImageView {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }

  private func makeIngredientLabel() -> UILabel {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }
}

private class HeaderView: UIView {
  private(set) lazy var label: UILabel = UILabel()

  required init(text: String) {
    super.init(frame: .zero)
    label.text = text
    addSubview(label)
    backgroundColor = Color.main

    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      label.centerYAnchor.constraint(equalTo: centerYAnchor),
      label.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
    ])
  }
}
