//
//  DebouncerTests.swift
//  RecipesTests
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import XCTest
@testable import Recipes

class DebouncerTests: XCTestCase {
  func testDebouncing() {
    let cancelExpectation = self.expectation(description: "cancel")
    cancelExpectation.isInverted = true

    let completeExpectation = self.expectation(description: "complete")
    let debouncer = Debouncer(delay: 0.3)

    debouncer.schedule {
      cancelExpectation.fulfill()
    }

    debouncer.schedule {
      completeExpectation.fulfill()
    }

    wait(for: [cancelExpectation, completeExpectation], timeout: 1)
  }
}
