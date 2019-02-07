//
//  AppDelegate.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 06/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit


struct ShowLog {
    static var show = true
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //переменная которая определяет, что приложение запускается первый раз для правильного отслеживания перехода по состояниям
    var firstStart: Bool = true
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //true - показать консоль
        ShowLog.show = true
        
        if ShowLog.show {
            print("Aplication state-> \(#function)")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if ShowLog.show {
            print("Application moved from applicationDidBecomeActive to -> \(#function)")
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if ShowLog.show {
            print("Application moved from applicationWillResignActive to -> \(#function)")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if ShowLog.show {
            print("Application moved from applicationDidEnterBackground to -> \(#function)")
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if ShowLog.show {
            if firstStart {
                print("Application moved from didFinishLaunchingWithOptions to -> \(#function)")
                firstStart = false
            } else {
                print("Application moved from applicationWillEnterForeground to -> \(#function)")
            }
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if ShowLog.show {
            print(#function)
        }
    }


}

