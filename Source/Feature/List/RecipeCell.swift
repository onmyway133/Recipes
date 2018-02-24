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
    view.backgroundColor = UIColor(hex: "#9E6BE0").withAlphaComponent(0.6)

    return view
  }()

  private(set) lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true

    return imageView
  }()

  private(set) lazy var label: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = UIFont.preferredFont(forTextStyle: .headline)

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
      containerView.topAnchor.constraint(equalTo: topAnchor, constant: 1),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),

      imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 4),
      imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
      imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),

      label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
      label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)
    ])
  }
}
