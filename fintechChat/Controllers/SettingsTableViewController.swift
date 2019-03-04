//
//  SettingsTableViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 05/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var themeColorBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // themeColorBtn.layer.cornerRadius = 5

    }
    
    @IBAction func themeOpenSetAction(_ sender: UIButton) {
        
    }
    
    @IBAction func closeView(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        
        if indexPath.section == 0 && indexPath.row == 0 {
           
            self.performSegue(withIdentifier: "ColorThemeView", sender: self)
        }
        
        
    }
}
