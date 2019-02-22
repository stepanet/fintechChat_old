//
//  ConversationsList.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 21/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration {
    
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessage: Bool {get set}
}

struct ConversationList: ConversationCellConfiguration {
    var name: String?
    var message: String? 
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
}


