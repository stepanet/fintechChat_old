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

protocol MessageCellConfiguration {
    var text: String? {get set}
    var fromUser: String? {get set}
    var toUser: String? {get set}
}

struct ConversationList: ConversationCellConfiguration {
    var name: String?
    var message: String? 
    var date: Date?
    var online: Bool
    var hasUnreadMessage: Bool
}


struct MessageLists: MessageCellConfiguration {
    var text: String?
    var fromUser: String?
    var toUser: String?
}


protocol SaveDataProtocol {
    var saveData: Bool {get set}
    var savePhoto: Bool {get set}
    var saveProfileName: Bool {get set}
    var saveAbout: Bool {get set}
    var textAlert: String? {get}
}

struct SaveData: SaveDataProtocol {
    
    var saveData: Bool = false
    var savePhoto: Bool = false
    var saveProfileName: Bool = false
    var saveAbout: Bool = false
    var textAlert: String?
    
    mutating func textAlertFunc() -> String {
        return self.saveData == true ?  "данные сохранены" : "данные не удалось записать"
    }
}


class MessageListClass: MessageCellConfiguration {
    //хочу доступ к массиву из всего проекта
    var array = [MessageLists]()
    var text: String?
    var fromUser: String?
    var toUser: String?
    
    
    func saveDataToArray(text: String, fromUser: String, toUSer: String) {
        let item = MessageLists(text: text, fromUser: fromUser, toUser: toUSer)
        array.append(item)
    }
    
}




