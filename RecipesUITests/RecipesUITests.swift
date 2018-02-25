//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import XCTest

class RecipesUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false

    app = XCUIApplication()
  }

  func testScrolling() {
    app.launch()

    let collectionView = app.collectionViews.element(boundBy: 0)
    collectionView.swipeUp()
    collectionView.swipeUp()
  }

  func testGoToDetail() {
    app.launch()

    let collectionView = app.collectionViews.element(boundBy: 0)
    let firstCell = collectionView.cells.element(boundBy: 0)
    firstCell.tap()
  }

  func testOpenInstructionInExternalWebPage() {
    testGoToDetail()

    let button = app.buttons["View instructions"]
    button.tap()
  }

  func testSearch() {
    app.launch()

    let searchField = app.searchFields.element(boundBy: 0)
    searchField.tap()

    searchField.typeText("banana")

    let collectionView = app.collectionViews.element(boundBy: 1)
    _ = collectionView.waitForExistence(timeout: 8)
    let firstCell = collectionView.cells.element(boundBy: 0)
    firstCell.tap()
  }
}
