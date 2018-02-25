Recipes App
==

## Description

- An app that showcases many recipes together with their detail information
- Contain lots of good practices for structuring iOS app and handle dependencies
- Support iOS 9+
- Use Xcode 9.3, Swift 4.0
- Ideas are from my experience and learnings from colleagues, community. Pull requests are more than welcome ❤️

<div align="center">
<img src="Screenshots/Home.png" height="500" />
<img src="Screenshots/Detail.png" height="500" />
</div>

### Minimum supported iOS version

- As of early 2018, the latest version is iOS 11
- See measurements about iOS adoption on [AppStore](https://developer.apple.com/support/app-store/)
- Apple suggests supporting 2 latest versions
- Supporting iOS 9 is not a pain for this app, it's good to have since there's quite a few percentage of users according to the chart below.
- Ideally, to determine when to drop support old iOS versions, we need analytics about how users use our app.

<div align="center">
<img src="Screenshots/AppStore.png" height="500" />
</div>


### Project

- Create new project, select both Unit Tests and UI Tests as we should write tests early.
- We can organise files by feature/module or role/types. Each has its pros and cons
- By role/type:
  - Pros: 
    - Less thinking about where to put files.
    - Easier to apply scripts or filter
  - Cons:
    - Hard to correlate if we want to find files related to same feature
    - Take time to reorganise files if we want to make them into reusable components
- By feature/module
  - Pros:
    - Make things modular
    - Encourage composition
  - Cons:
    - May be messy when many files of different types stay close

### Modular

- It may depend on projects, but I usually group things by feature/module. It answers the question "What does this app do?" instead of "What is this file?".

  - Source: contains source code files, splitted into features
    - Features: contain main features in the app
      - Home: the home screen, showing a list of recipes and open search
      - List: show a list of recipes, know how to reload and show empty view
      - Search: handle search and debouncing
      - Detail: show detail information
    - Library
      - Flow: contains FlowController to manage flows
      - Adapater: Generic data source for `UICollectionView`
      - Extension: convenient extensions for common operations
      - Model: The model in the app, parsed from json
  - Resource: contains plist, resource, Storyboard files

![](Screenshots/Project.png)

### Code convention

- I agree with most of the style guides in https://github.com/raywenderlich/swift-style-guide and https://github.com/github/swift-style-guide
- Use consistent and easy-to-reason indentation [Indenting Swift code](https://github.com/onmyway133/blog/issues/93)
- Prefer camelCase [Using camelCase for abbreviations](https://github.com/onmyway133/blog/issues/147)

### Git

- Use `.gitignore` file from https://www.gitignore.io/api/swift
- There are both pros and cons in [checking in dependencies](https://guides.cocoapods.org/using/using-cocoapods#should-i-check-the-pods-directory-into-source-control) files (CocoaPods and Carthage). Here I choose to ignore them to not clutter the code base.

> Whether or not you check in the Pods directory, the Podfile and Podfile.lock should always be kept under version control.

### Launch Screen

- Prefer using `LaunchScreen.storyboard`
- Add launch image to `Asset Catalog`, open `LaunchScreen.storyboard`, add `UIImageView` and pin it to the egdes of `UIView`
- Should not pin to Safe Area as we want image to be full screen. Also unselect any margins in Auto Layout constraints
- Set `UIImageView` 's `contentMode` as `Aspect Fill`

![](Screenshots/LaunchScreen.png)

### App Icon

- Make sure image has no transparent pixels, otherwise it results in black background. Read [
Human Interface Guidelines - App Icon](https://developer.apple.com/ios/human-interface-guidelines/icons-and-images/app-icon/)

> Keep the background simple and avoid transparency. Make sure your icon is opaque, and don’t clutter the background. Give it a simple background so it doesn’t overpower other app icons nearby. You don’t need to fill the entire icon with content.

- Preferrably use image with size greater than 1024x1024
- Use [IconGenerator](https://github.com/onmyway133/IconGenerator) to generate `AppIcon.appiconset`

![](Screenshots/AppIcon.png)

### API

- Register for account in http://food2fork.com/about/api
- I use [1Password](https://1password.com/) to generate and store my passwords.
- I use [Insomnia](https://github.com/getinsomnia/insomnia) to test and analyze API response.

![](Screenshots/Insomnia.png)

### SwiftLint

- Regardless of what platform we develop, it's good to have a linter to enfore consistent conventions
- I use [SwiftLint](https://github.com/realm/SwiftLint)
- Add `pod 'SwiftLint', '~> 0.25'` to `Podfile`. It's also a good practice to specify [version](https://guides.cocoapods.org/syntax/podfile.html#pod) of the dependencies
- Add `.swiftlint.yml`. A sample can be found [here](https://github.com/realm/SwiftLint/blob/master/.swiftlint.yml)
- Add new Run Script Phrase to execute `swiftlint` after compiling

![](Screenshots/SwiftLint.png)

### Model

- It may sound boring but clients are just a prettier way to represent the API response. The model is perhaps the most basic thing and we use it a lot in the app. It plays such an important role and there can be some obvious bugs related to malformed models and assumption about how a model should be parsed.
- We should have test for every model of the app. Ideally we need automate testing of models from API response in case the model is changed from the backend.
- From Swift 4, we can conform our model to [Codable](https://developer.apple.com/documentation/swift/codable) to easily serialise to and from json.
- Model should be immutable

```swift
struct Recipe: Codable {
  let publisher: String
  let url: URL
  let sourceUrl: String
  let id: String
  let title: String
  let imageUrl: String
  let socialRank: Double
  let publisherUrl: URL

  enum CodingKeys: String, CodingKey {
    case publisher
    case url = "f2f_url"
    case sourceUrl = "source_url"
    case id = "recipe_id"
    case title
    case imageUrl = "image_url"
    case socialRank = "social_rank"
    case publisherUrl = "publisher_url"
  }
}
```

- We can use some test frameworks if you like fancy syntax or Rspec style. Some 3rd party test frameworks may have issues. I find `XCTest` good enough.

```swift
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

```

### FlowController

- FlowController is used to manage many `UIViewController` related to a common feature.
- Read [FlowController and Coordinator](https://github.com/onmyway133/blog/issues/106)
- There are `AppFlowController` that manages changing `rootViewController`. For now it start `RecipesFlowController`

```swift
window = UIWindow(frame: UIScreen.main.bounds)
window?.rootViewController = appFlowController
window?.makeKeyAndVisible()
appFlowController.start()
```

- `RecipesFlowController` manages, in fact it is, `UINavigationController`, that handles pushing `HomeViewController, RecipesDetailViewController, SafariViewController`

```swift
final class RecipeFlowController: UINavigationController {
  /// Start the flow
  func start() {
    let service = RecipesService(networking: NetworkService())
    let controller = HomeViewController(recipesService: service)
    viewControllers = [controller]
    controller.select = { [weak self] recipe in
      self?.startDetail(recipe: recipe)
    }
  }

  private func startDetail(recipe: Recipe) {}
  private func startWeb(url: URL) {}
}
```

- The `UIViewController` can use `delegate` or `closure` to notify `FlowController` about changes or next screen in the flow. For `delegate` there may need for check when there are 2 instances of the same classes. Here we use `closure` for simplicity.

### Auto Layout

- I try to use Auto Layout as much as possible to make adaptive UI.
- We can use libraries like [Anchors](https://github.com/onmyway133/Anchors) to do declarative and fast Auto Layout.
- However in this app, we can just use `NSLayoutAnchor` since it is from iOS 9.
- Inspired by [Constraint](https://github.com/hyperoslo/Sugar/blob/master/Sources/iOS/Constraint.swift)

```swift
extension NSLayoutConstraint {
  static func activate(_ constraints: [NSLayoutConstraint]) {
    constraints.forEach {
      ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
      $0.isActive = true
    }
  }
}
```

## Credit

- Launch image is from http://desertrosemediapa.com/
- App icon is from https://www.flaticon.com/free-icon/rice_168559

## Licence

This project is released under the MIT license. See LICENSE.md.
