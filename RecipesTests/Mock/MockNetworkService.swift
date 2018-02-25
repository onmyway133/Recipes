//
//  MockNetworkService.swift
//  RecipesTests
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation
@testable import Recipes

final class MockNetworkService: Networking {
  let data: Data
  init(fileName: String) {
    let bundle = Bundle(for: MockNetworkService.self)
    let url = bundle.url(forResource: fileName, withExtension: "json")!
    self.data = try! Data(contentsOf: url)
  }

  func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
    completion(data)
    return nil
  }
}
