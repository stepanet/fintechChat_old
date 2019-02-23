//
//  MeMessageTableViewCell.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 23/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageText: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        messageText.layer.cornerRadius = 15
        messageText.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
