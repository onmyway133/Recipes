//
//  BaseController.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Used to separate between controller and view
class BaseController<T: UIView>: UIViewController {
  let root = T()

  override func loadView() {
    view = root
  }
}
