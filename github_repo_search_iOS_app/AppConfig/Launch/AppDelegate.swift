//
//  AppDelegate.swift
//  github_repo_search_iOS_app
//
//  Created by Dinakar Maurya on 2021/08/12.
//

import UIKit

/**
 Shared settings for the app
 */
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("configurationForConnecting .... Default Configuration")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
