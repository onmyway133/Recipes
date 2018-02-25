//
//  RecipesService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

final class RecipesService {
  private let baseUrl = URL(string: "https://food2fork.com/api")!
  private let networkService: NetworkService

  init(networkService: NetworkService) {
    self.networkService = networkService
  }

  /// Fetch recipes with highest rating
  ///
  /// - Parameter completion: Called when operation finishes
  func fetchTopRating(completion: @escaping ([Recipe]) -> Void) {
    let resource = Resource(url: baseUrl, path: "search", parameters: [
      "key": AppConfig.apiKey
    ])

    _ = networkService.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(data.flatMap({ RecipeListResponse.make(data: $0)?.recipes }) ?? [])
      }
    })
  }

  /// Fetch single entity based on recipe id
  ///
  /// - Parameters:
  ///   - recipeId: The recipe id
  ///   - completion: Called when operation finishes
  func fetch(recipeId: String, completion: @escaping (Recipe?) -> Void) {
    let resource = Resource(url: baseUrl, path: "get", parameters: [
      "key": AppConfig.apiKey,
      "rId": recipeId
    ])

    _ = networkService.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(data.flatMap({ RecipeResponse.make(data: $0)?.recipe }))
      }
    })
  }

  /// Search recipes based on query
  ///
  /// - Parameters:
  ///   - query: The search query
  ///   - completion: Called when operation finishes
  /// - Returns: The network task
  @discardableResult func search(query: String, completion: @escaping ([Recipe]) -> Void) -> URLSessionTask? {
    let resource = Resource(url: baseUrl, path: "search", parameters: [
      "key": AppConfig.apiKey,
      "q": query
    ])

    return networkService.fetch(resource: resource, completion: { data in
      DispatchQueue.main.async {
        completion(data.flatMap({ RecipeListResponse.make(data: $0)?.recipes }) ?? [])
      }
    })
  }
}

private class RecipeListResponse: Decodable {
  let count: Int
  let recipes: [Recipe]

  static func make(data: Data) -> RecipeListResponse? {
    return try? JSONDecoder().decode(RecipeListResponse.self, from: data)
  }
}

private class RecipeResponse: Decodable {
  let recipe: Recipe

  static func make(data: Data) -> RecipeResponse? {
    return try? JSONDecoder().decode(RecipeResponse.self, from: data)
  }
}
