//
//  Networking.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

protocol Networking {

  /// Fetch data from url and parameters query
  ///
  /// - Parameters:
  ///   - url: The url
  ///   - parameters: Parameters as query items
  ///   - completion: Called when operation finishes
  /// - Returns: The data task
  @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask?
}
