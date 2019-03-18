//
//  ConversationViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 23/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    

    var conversationData = [ConversationList]()
    var messageLists = [MessageLists]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessage()
        self.navigationItem.title = conversationData[0].name
        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        self.tableView.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }

}

extension ConversationViewController: UITableViewDelegate {
   
}


extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
            let text = messageLists[indexPath.row].text
            
            cell.messageText.text = text
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MessageTableViewCell
            let text = messageLists[indexPath.row].text
            
            cell.messageText.text = text
            return cell
        }
    }
    
    func loadMessage() {
        let item = MessageLists(text: "привет",fromUser: "Вася",toUser: "Петя" )
        let item1 = MessageLists(text: "привет",fromUser: "Вася1",toUser: "Петя1" )
        let item2 = MessageLists(text: "как дела?",fromUser: "Вася2",toUser: "Петя2" )
        let item3 = MessageLists(text: "отлично. делаю домашку",fromUser: "Вася3",toUser: "Петя3" )
        let item4 = MessageLists(text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",fromUser: "Вася5",toUser: "Петя5")
        let item5 = MessageLists(text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",fromUser: "Вася4",toUser: "Петя4" )
        messageLists.append(item)
        messageLists.append(item1)
        messageLists.append(item2)
        messageLists.append(item3)
        messageLists.append(item4)
        messageLists.append(item5)
    }
}
