//
//  ConversationsListViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 21/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {

    var conversationLists = [ConversationList]()
    var conversationListsOnline = [ConversationList]()
    var conversationListsHistory = [ConversationList]()
    var conversation = [ConversationList]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()

    }

}


extension ConversationsListViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case  0:
              return "Online"
        case  1:
             return "History"
        default:
            break
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
}

extension ConversationsListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
        
        
        
        conversation = [conversationLists[indexPath.row]]
        
        //_ = self.navigationController?.popToRootViewController(animated: true)
        //performSegue(withIdentifier: "showDetails", sender: self)
        //showConversationViewController(conversation)
    
    }
    
    
    //подготовка данных для пересылки во вьюконтроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        if let destination = segue.destination as? ConversationViewController {
            
            destination.conversationList = conversationLists

            print("segue.ConversationViewController")
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return conversationListsOnline.count
        }
        return conversationListsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConversationTableViewCell {
            
            switch indexPath.section {
            case 0:
                let itemCellOnline = conversationListsOnline[indexPath.row]
                cell.backgroundColor = UIColor(named: "littelYellow")
                cell.dataCell(itemCellOnline)
                break
            case 1:
                let itemCellHistory = conversationListsHistory[indexPath.row]
                cell.dataCell(itemCellHistory)
                break
            default:
                break
            }
            
            return cell
        }
        return UITableViewCell()
    }

    
    func loadData() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        
        let item = ConversationList(name: "Вася", message: "Привет, как дела?", date: dateFormatter.date(from: "2019-01-01 01:11:01"), online: false, hasUnreadMessage: true)
        let item1 = ConversationList(name: "Петя", message: "Дай телефон Звезды", date: Date(), online: true, hasUnreadMessage: false)
        let item3 = ConversationList(name: "Дима", message: "Как дз? сделал?", date: dateFormatter.date(from: "2019-01-06 08:51:01"), online: false, hasUnreadMessage: true)
        let item4 = ConversationList(name: "Света", message: "Привет сладкий", date: Date(), online: true, hasUnreadMessage: true)
        let item5 = ConversationList(name: "Звезда", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-05 11:21:01"), online: false, hasUnreadMessage: false)
        let item6 = ConversationList(name: "Соня", message: nil, date: Date(), online: true, hasUnreadMessage: true)
        conversationLists.append(item)
        conversationLists.append(item1)
        conversationLists.append(item3)
        conversationLists.append(item4)
        conversationLists.append(item5)
        conversationLists.append(item6)
        
        for i in conversationLists {
            if i.online {
                conversationListsOnline.append(i)
            } else {
                conversationListsHistory.append(i)
            }
        }
    }
    
    

    func showConversationViewController(_ conversationList: ConversationList) {
        
        let conversationViewController = ConversationViewController()
        
        //в переменную conversationList контроллера ConversationViewController передаем данные
        conversationViewController.conversationList = [conversationList]
        
        //обьявить и показать контроллер
        let navController = UINavigationController(rootViewController: conversationViewController)
        present(navController, animated: true, completion: nil)
    }
    
}
