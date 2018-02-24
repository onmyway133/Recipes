import XCTest
@testable import Recipes

class RecipesTests: XCTestCase {
  func testParsing() throws {
    let json: [String: Any] = [
      "publisher": "Two Peas and Their Pod",
      "f2f_url": "http://food2fork.com/view/975e33",
      "title": "No-Bake Chocolate Peanut Butter Pretzel Cookies",
      "source_url": "http://www.twopeasandtheirpod.com/no-bake-chocolate-peanut-butter-pretzel-cookies/",
      "recipe_id": "975e33",
      "image_url": "http://static.food2fork.com/NoBakeChocolatePeanutButterPretzelCookies44147.jpg",
      "social_rank": 99.99999999999974,
      "publisher_url": "http://www.twopeasandtheirpod.com"
    ]

    let data = try JSONSerialization.data(withJSONObject: json, options: [])
    let decoder = JSONDecoder()
    let recipe = try decoder.decode(Recipe.self, from: data)

    XCTAssertEqual(recipe.title, "No-Bake Chocolate Peanut Butter Pretzel Cookies")
    XCTAssertEqual(recipe.id, "975e33")
    XCTAssertEqual(recipe.url, URL(string: "http://food2fork.com/view/975e33")!)
  }
}

