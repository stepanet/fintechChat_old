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
        
        #if SHOWLOG
            print("SHOWLOG FLAG SET")
            showPrint(actionName: "Aplication state-> ", funcName: "didFinishLaunchingWithOptions")
        #endif
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        #if SHOWLOG
        showPrint(actionName: "Application moved from applicationDidBecomeActive to -> ", funcName: "applicationWillResignActive")
        #endif
        
        
//        if ShowLog.show {
//            print("Application moved from applicationDidBecomeActive to -> \(#function)")
//        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        #if SHOWLOG
        showPrint(actionName: "Application moved from applicationWillResignActive to -> ", funcName: "applicationDidEnterBackground")
        #endif
        
//        if ShowLog.show {
//            print("Application moved from applicationWillResignActive to -> \(#function)")
//        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        #if SHOWLOG
        showPrint(actionName: "Application moved from applicationDidEnterBackground to -> ", funcName: "applicationWillEnterForeground")
        #endif
        
//        if ShowLog.show {
//            print("Application moved from applicationDidEnterBackground to -> \(#function)")
//        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        #if SHOWLOG

        
        if firstStart {
            showPrint(actionName: "Application moved from didFinishLaunchingWithOptions to -> ", funcName: "applicationDidBecomeActive")
            //print("Application moved from didFinishLaunchingWithOptions to -> \(#function)")
            firstStart = false
        } else {
             showPrint(actionName: "Application moved from applicationWillEnterForeground to -> ", funcName: "applicationDidBecomeActive")
            //print("Application moved from applicationWillEnterForeground to -> \(#function)")
        }
        
        #endif
        
//        if ShowLog.show {
//            if firstStart {
//                print("Application moved from didFinishLaunchingWithOptions to -> \(#function)")
//                firstStart = false
//            } else {
//                print("Application moved from applicationWillEnterForeground to -> \(#function)")
//            }
//        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        #if SHOWLOG
        showPrint(actionName: "Application state", funcName: "applicationWillTerminate")
        #endif
        
//        if ShowLog.show {
//            print(#function)
//        }
    }
    
    func showPrint(actionName: String, funcName: String) {
        
        print(actionName + funcName)
    }

}

