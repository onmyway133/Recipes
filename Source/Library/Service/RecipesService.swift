//
//  RecipesService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

final class RecipesService {
  private let baseUrl = URL(string: "https://food2fork.com/api/search")!
  private let networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }

  @discardableResult func fetchTopRating(completion: @escaping ([Recipe]) -> Void) -> URLSessionTask? {
    let resource = NetworkService.Resource(url: baseUrl)
    return networkService.fetch(resource: resource, completion: { data in
      completion(data.flatMap({ RecipesResponse.make(data: $0)?.recipes }) ?? [])
    })
  }

  @discardableResult func search(query: String, completion: @escaping ([Recipe]) -> Void) -> URLSessionTask? {
    let resource = NetworkService.Resource(url: baseUrl, parameters: [
      "q": query
    ])

    return networkService.fetch(resource: resource, completion: { data in
      completion(data.flatMap({ RecipesResponse.make(data: $0)?.recipes }) ?? [])
    })
  }
}

private class RecipesResponse: Decodable {
  let count: Int
  let recipes: [Recipe]

  static func make(data: Data) -> RecipesResponse? {
    return try? JSONDecoder().decode(RecipesResponse.self, from: data)
  }
}
