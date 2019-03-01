//
//  ThemeManager.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 01/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit
import Foundation


enum Theme: Int {
    
    case ligth, dark, shampan
    
    var mainColor: UIColor {
        switch self {
        case .ligth:
            return UIColor(named: "blueColor")!
        case .dark:
            return UIColor(named: "darkColor")!
        case .shampan:
            return UIColor(named: "littelYellow")!
        }
    }

    var barStyle: UIBarStyle {
        switch self {
        case .ligth:
            return .default
        case .dark:
            return .black
        case .shampan:
            return .black
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ligth:
            return UIColor(named: "blueColor")!
        case .dark:
            return UIColor(named: "darkColor")!
        case .shampan:
            return UIColor(named: "littelYellow")!
        }
    }
    
    var secondaryColor: UIColor {
        switch self {
        case .ligth:
            return UIColor(named: "blueColor")!
        case .dark:
            return UIColor(named: "darkColor")!
        case .shampan:
            return UIColor(named: "littelYellow")!

        }
    }
    
    var titleTextColor: UIColor {
        switch self {
        case .ligth:
            return UIColor(named: "blueColor")!
        case .dark:
            return UIColor(named: "darkColor")!
        case .shampan:
            return UIColor(named: "littelYellow")!

        }
    }
    var subtitleTextColor: UIColor {
        switch self {
        case .ligth:
            return UIColor(named: "blueColor")!
        case .dark:
            return UIColor(named: "darkColor")!
        case .shampan:
            return UIColor(named: "littelYellow")!

        }
    }
}

let SelectedThemeKey = "SelectedTheme"


class ThemeManager {

    static func currentTheme() -> Theme {
        if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
            return Theme(rawValue: storedTheme)!
        } else {
            return .shampan
        }
    }
    
    static func applyTheme(theme: Theme) {
        
        UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()

        let sharedApplication = UIApplication.shared
        sharedApplication.delegate?.window??.tintColor = theme.mainColor
        
        UINavigationBar.appearance().barStyle = theme.barStyle
        UITabBar.appearance().barStyle = theme.barStyle
//        UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
//        UISwitch.appearance().thumbTintColor = theme.mainColor
    }
}
