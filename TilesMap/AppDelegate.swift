//
//  AppDelegate.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import UIKit
import NetworkLayer

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ApiClient.shared.baseUrl = URL(string:"https://next.json-generator.com/api/json/get/")!
        return true
    }
}

