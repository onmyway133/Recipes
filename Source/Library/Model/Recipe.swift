import Foundation

/// Represent a recipe from API response
struct Recipe: Codable {
  let publisher: String

  /// Url of the recipe on Food2Fork.com
  let url: URL

  /// URL of the image
  let sourceUrl: String
  let id: String

  /// Title of the recipe
  let title: String

  /// URL of the image
  let imageUrl: String
  let socialRank: Double
  let publisherUrl: URL
}
