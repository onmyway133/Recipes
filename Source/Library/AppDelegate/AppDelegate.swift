//
//  AppDelegate.swift
//  Recipes
//
//  Created by Khoa Pham on 24.02.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let appFlowController = AppFlowController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = appFlowController
    window?.makeKeyAndVisible()

    appFlowController.start()

    return true
  }
}
