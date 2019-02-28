//
//  AppDelegate.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 06/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let theme = userDefaults.object(forKey: "theme") {
            print(theme)
                switch theme as? String {
                case ".ligth":
                    ThemeManager.applyTheme(theme: .ligth)
                case ".dark":
                    print("dark theme selected")
                    ThemeManager.applyTheme(theme: .dark)
                case ".shampan":
                    ThemeManager.applyTheme(theme: .shampan)
                default:
                    break
                }
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

        
    }

}

