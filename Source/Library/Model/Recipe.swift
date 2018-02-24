import Foundation

/// Represent a recipe from API response
struct Recipe: Codable {
  /// Name of the Publisher
  let publisher: String

  /// Url of the recipe on Food2Fork.com
  let url: URL

  /// URL of the image
  let sourceUrl: String

  /// id of recipe
  let id: String

  /// Title of the recipe
  let title: String

  /// URL of the image
  let imageUrl: String

  /// The Social Ranking of the Recipe
  let socialRank: Double

  /// Base url of the publisher
  let publisherUrl: URL
}
