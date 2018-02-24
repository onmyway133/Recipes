//
//  ImageService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

/// Save and load data to memory and disk cache
final class CacheService {
  /// Save data
  ///
  /// - Parameters:
  ///   - data: The data to save
  ///   - key: Key to identify cached item
  func save(data: Data, key: String) {

  }

  /// Load data specified by key
  ///
  /// - Parameters:
  ///   - key: Key to identify cached item
  ///   - completion: Called when operation finishes
  func load(key: String, completion: (Data?) -> Void) {
    completion(nil)
  }
}
