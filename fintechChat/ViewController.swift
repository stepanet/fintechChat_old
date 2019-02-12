//
//  ViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 06/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "backGrndColor")

    }
    
    override func viewDidLayoutSubviews() {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
    
    override func viewWillLayoutSubviews() {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        #if SHOWLOG
            print(#function)
        #endif
    }
}

