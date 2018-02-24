//
//  ImageService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

/// Check local cache and fetch remote image
class ImageService {

  private let networkService: NetworkService
  private let cacheService: CacheService
  private var task: URLSessionTask?

  init(networkService: NetworkService, cacheService: CacheService) {
    self.networkService = networkService
    self.cacheService = cacheService
  }

  /// Fetch image from url
  ///
  /// - Parameters:
  ///   - url: The remote url for image
  ///   - completion: Called when operation finishes
  func fetch(url: URL, completion: @escaping (UIImage?) -> Void) {
    // Cancel existing task if any
    task?.cancel()

    // Try load from cache
    cacheService.load(key: url.absoluteString, completion: { [weak self] cachedData in
      if let data = cachedData, let image = UIImage(data: data) {
        completion(image)
      } else {
        // Try to request from network
        let resource = NetworkService.Resource(url: url)
        self?.task = self?.networkService.fetch(resource: resource, completion: { networkData in
          if let data = networkData, let image = UIImage(data: data) {
            // Save to cache
            self?.cacheService.save(data: data, key: url.absoluteString)
            completion(image)
          } else {
            assertionFailure()
          }
        })

        self?.task?.resume()
      }
    })
  }
}
