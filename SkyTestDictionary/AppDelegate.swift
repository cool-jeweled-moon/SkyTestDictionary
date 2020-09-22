//
//  AppDelegate.swift
//  SkyTestDictionary
//
//  Created by Борис Анели on 18.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavigationController = UINavigationController(rootViewController: WordsSearchViewController())
        window?.rootViewController = rootNavigationController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
}

