//
//  ConversationViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 23/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationViewController: UIViewController {
    

    var conversationData = [ConversationList]()
    var messageLists = [MessageLists]()
    var fromUser: String?
    var toUser: String?
    var session: MCSession!
    
    @IBOutlet weak var messageTxtField: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = fromUser
        
        print("session", session)
        
        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        self.tableView.backgroundColor = ThemeManager.currentTheme().backgroundColor
    }

    @IBAction func sendMsgActionBtn(_ sender: UIButton) {
        if (messageTxtField.text?.count)! > 0 {
            
            //добавим сообщение в массив
//            addDataToArrayMsg(text: messageTxtField.text!, fromUser: fromUser!, toUser: toUser!)
//
//            tableView.reloadData()
        }
    }
}

extension ConversationViewController: UITableViewDelegate {
}


extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (messageLists[indexPath.row].toUser == fromUser ) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MessageTableViewCell
            let text = messageLists[indexPath.row].text
            
            cell.messageText.text = text
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
            let text = messageLists[indexPath.row].text
            
            cell.messageText.text = text
            return cell
        }
    }
    
    
    
    
    func addDataToArrayMsg(text: String, fromUser: String, toUser: String){
        let item = MessageLists(text: text,fromUser: fromUser,toUser: fromUser )
        messageLists.append(item)
        
        //хотелось бы отослать пиру, но болт Ж) не работае пока что
        //sendText(text: text, peerID: session!.connectedPeers)
    }
    
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("didReceiveData: \(data)")
        let str = String(data: data, encoding: .utf8)!
        print(str)
    }
    
    func sendText(text: String, peerID: MCPeerID) {
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(text.data(using: .utf8)!, toPeers: [peerID], with: .reliable)
            }
            catch let error {
                print("Ошибка отправки: \(error)")
            }
        }
    }
    
    
//    //подготовка данных для пересылки во вьюконтроллер
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ConversationListViewController {
//            destination.messageLists = messageLists
//        }
//    }
    
    
    
    func loadMessage() {
        /*
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
    */
    }
}
