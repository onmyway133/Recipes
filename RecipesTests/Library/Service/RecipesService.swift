//
//  RecipesService.swift
//  RecipesTests
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import XCTest
@testable import Recipes

class RecipesServiceTests: XCTestCase {
  func testFetchTopRating() {
    let expectation = self.expectation(description: #function)
    let mockNetworkService = MockNetworkService(fileName: "recipes")
    let recipesService = RecipesService(networking: mockNetworkService)
    recipesService.fetchTopRating(completion: { recipes in
      XCTAssertEqual(recipes.count, 30)
      expectation.fulfill()
    })

    wait(for: [expectation], timeout: 1)
  }
}
