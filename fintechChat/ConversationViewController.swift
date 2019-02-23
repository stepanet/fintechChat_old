//
//  ConversationViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 23/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    struct MessageLists: MessageCellConfiguration {
        var text: String?
    }
    
    var conversationData = [ConversationList]()
    var messageLists = [MessageLists]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessage()

        self.navigationItem.title = conversationData[0].name
        // Do any additional setup after loading the view.
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MyMessageTableViewCell
            let text = messageLists[indexPath.row].text
            
            cell.messageText.text = text
            return cell
            
        }
        

        
    }
    
    
    func loadMessage() {
        let item = MessageLists(text: "привет")
        let item1 = MessageLists(text: "привет")
        let item2 = MessageLists(text: "как дела?")
        let item3 = MessageLists(text: "отлично. делаю домашку")
        messageLists.append(item)
        messageLists.append(item1)
        messageLists.append(item2)
        messageLists.append(item3)

    }
    
}
