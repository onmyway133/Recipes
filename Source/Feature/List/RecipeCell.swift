//
//  RecipeCell.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

final class RecipeCell: UICollectionViewCell {
  private(set) lazy var containerView: UIView = {
    let view = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 5

    return view
  }()

  private(set) lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private(set) lazy var label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(containerView)
    containerView.addSubview(imageView)
    containerView.addSubview(label)

    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
      containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),

      imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
      imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.9),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),

      label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
      label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)
    ])
  }
}
