//
//  ImageService.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation
import SwiftHash

/// Save and load data to memory and disk cache
final class CacheService {

  /// For get or load data in memory
  private let memory = NSCache<NSString, NSData>()

  /// The path url that contain cached files (mp3 files and image files)
  private let diskPath: URL

  /// For checking file or directory exists in a specified path
  private let fileManager: FileManager

  /// Make sure all operation are executed serially
  private let serialQueue = DispatchQueue(label: "Recipes")

  init(fileManager: FileManager = FileManager.default) {
    self.fileManager = fileManager
    do {
      let documentDirectory = try fileManager.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: true
      )
      diskPath = documentDirectory.appendingPathComponent("Recipes")
      try createDirectoryIfNeeded()
    } catch {
      fatalError()
    }
  }

  /// Save data
  ///
  /// - Parameters:
  ///   - data: The data to save
  ///   - key: Key to identify cached item
  func save(data: Data, key: String, completion: (() -> Void)? = nil) {
    let key = MD5(key)

    serialQueue.async {
      self.memory.setObject(data as NSData, forKey: key as NSString)
      do {
        try data.write(to: self.filePath(key: key))
        completion?()
      } catch {
        print(error)
      }
    }
  }

  /// Load data specified by key
  ///
  /// - Parameters:
  ///   - key: Key to identify cached item
  ///   - completion: Called when operation finishes
  func load(key: String, completion: @escaping (Data?) -> Void) {
    let key = MD5(key)

    serialQueue.async {
      // If object is in memory
      if let data = self.memory.object(forKey: key as NSString) {
        completion(data as Data)
        return
      }

      // If object is in disk
      if let data = try? Data(contentsOf: self.filePath(key: key)) {
        // Set back to memory
        self.memory.setObject(data as NSData, forKey: key as NSString)
        completion(data)
        return
      }

      completion(nil)
    }
  }

  /// Convenient method to access file named key in diskPath directory
  ///
  /// - Parameter key: The key, this is the file name
  /// - Returns: The file url
  private func filePath(key: String) -> URL {
    return diskPath.appendingPathComponent(key)
  }

  private func createDirectoryIfNeeded() throws {
    if !fileManager.fileExists(atPath: diskPath.path) {
      try fileManager.createDirectory(at: diskPath, withIntermediateDirectories: false, attributes: nil)
    }
  }

  /// Clear all items in memory and disk cache
  func clear() throws {
    memory.removeAllObjects()
    try fileManager.removeItem(at: diskPath)
    try createDirectoryIfNeeded()
  }
}
