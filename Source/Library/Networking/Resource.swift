//
//  Resource.swift
//  Recipes
//
//  Created by Khoa Pham on 25.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation

// A network resource, identified by url and parameters
struct Resource {
  let url: URL
  let path: String?
  let httpMethod: String
  let parameters: [String: String]

  init(url: URL, path: String? = nil, httpMethod: String = "GET", parameters: [String: String] = [:]) {
    self.url = url
    self.path = path
    self.httpMethod = httpMethod
    self.parameters = parameters
  }
}
