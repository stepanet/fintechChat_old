//
//  ThemesViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 01/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    let theme = ThemeManager.currentTheme()
    
    @IBOutlet weak var ligthThemeBtn: UIButton!
    @IBOutlet weak var darkThemeBtn: UIButton!
    @IBOutlet weak var shampanThemeBtn: UIButton!
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBtnAndView()
        
    }
    
    @IBAction func closeThemeView(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupBtnAndView() {
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        ligthThemeBtn.layer.cornerRadius = 5
        darkThemeBtn.layer.cornerRadius = 5
        shampanThemeBtn.layer.cornerRadius = 5
        ligthThemeBtn.clipsToBounds = true
        darkThemeBtn.clipsToBounds = true
        shampanThemeBtn.clipsToBounds = true
    }
    
    @IBAction func changeThemeAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            print("ligth")
            UserDefaults.standard.set(".ligth", forKey: "theme")
            ThemeManager.applyTheme(theme: .ligth)
            
        case 1:
            print("dark")
            UserDefaults.standard.set(".dark", forKey: "theme")
            ThemeManager.applyTheme(theme: .dark)
        case 2:
            print("shampan")
            UserDefaults.standard.set(".shampan", forKey: "theme")
            ThemeManager.applyTheme(theme: .shampan)
        default:
            break
        }

        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }
    
}
