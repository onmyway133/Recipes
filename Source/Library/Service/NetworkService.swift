//
//  NetworkService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

/// Used to fetch data from network
final class NetworkService: Networking {
  private let session: URLSession

  init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
    self.session = URLSession(configuration: configuration)
  }

  @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
    guard let request = makeRequest(resource: resource) else {
      completion(nil)
      return nil
    }

    let task = session.dataTask(with: request, completionHandler: { data, _, error in
      guard let data = data, error == nil else {
        completion(nil)
        return
      }

      completion(data)
    })

    task.resume()
    return task
  }

  /// Convenient method to make request
  ///
  /// - Parameters:
  ///   - resource: Network resource
  /// - Returns: Constructed URL request
  private func makeRequest(resource: Resource) -> URLRequest? {
    let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
    guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
      assertionFailure()
      return nil
    }

    component.queryItems = resource.parameters.map({
      return URLQueryItem(name: $0, value: $1)
    })

    guard let resolvedUrl = component.url else {
      assertionFailure()
      return nil
    }

    var request = URLRequest(url: resolvedUrl)
    request.httpMethod = resource.httpMethod
    return request
  }
}
