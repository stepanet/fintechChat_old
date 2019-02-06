//
//  ViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 06/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//  Test github

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(named: "backGrndColor")
        
        //есть сомнения, но без закрытия view эти методы не работают
        self.viewWillDisappear(true)
        self.viewDidDisappear(true)

    }
    
    
    
    override func viewDidLayoutSubviews() {
        if ShowLog.show {
            print(#function)
        }
    }
    
    override func viewWillLayoutSubviews() {
        if ShowLog.show {
            print(#function)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ShowLog.show {
            print(#function)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if ShowLog.show {
            print(#function)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ShowLog.show {
            print(#function)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if ShowLog.show {
            print(#function)
        }
    }
    


}

