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
}
