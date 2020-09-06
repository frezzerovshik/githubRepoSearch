//
//  AppDelegate.swift
//  github_api_task
//
//  Created by Артем Шарапов on 04.09.2020.
//  Copyright © 2020 Artem Sharapov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let navController = UINavigationController(rootViewController: SearchRepoViewController())

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

