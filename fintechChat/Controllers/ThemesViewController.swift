//
//  ThemesViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 01/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    
    @IBOutlet weak var ligthThemeBtn: UIButton!
    @IBOutlet weak var darkThemeBtn: UIButton!
    @IBOutlet weak var shampanThemeBtn: UIButton!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBtn()
        
    }
    
    @IBAction func closeThemeView(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupBtn() {
        // Do any additional setup after loading the view.
        
        ligthThemeBtn.layer.cornerRadius = 5
        darkThemeBtn.layer.cornerRadius = 5
        shampanThemeBtn.layer.cornerRadius = 5
        ligthThemeBtn.clipsToBounds = true
        darkThemeBtn.clipsToBounds = true
        shampanThemeBtn.clipsToBounds = true
    }
    

}
