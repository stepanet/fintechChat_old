//
//  ConversationsListViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 21/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit



class ConversationsListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var conversationLists = [ConversationList]()
    var conversationListsOnline = [ConversationList]()
    var conversationListsHistory = [ConversationList]()
    var conversationData = [ConversationList]()

    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        loadData()

    }
}

extension ConversationsListViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "Online" : "History"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}

extension ConversationsListViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            conversationData = [conversationListsOnline[indexPath.row]]
        } else {
            conversationData = [conversationListsHistory[indexPath.row]]
        }
     
        _ = self.navigationController?.popToRootViewController(animated: true)
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    
    //подготовка данных для пересылки во вьюконтроллер
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? ConversationViewController {
            destination.conversationData = conversationData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return section == 0 ? conversationListsOnline.count : conversationListsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConversationTableViewCell {
            
            //вместо переиспользования ячейки
//            cell.backgroundColor = ThemeManager.currentTheme().backgroundColor
//            cell.nameLbl.textColor = ThemeManager.currentTheme().titleTextColor
//            cell.messageLbl.textColor = ThemeManager.currentTheme().titleTextColor
//            cell.dateLbl.textColor = ThemeManager.currentTheme().titleTextColor
            
            
            switch indexPath.section {
            case 0:
                let itemCellOnline = conversationListsOnline[indexPath.row]
                cell.nameLbl.textColor = ThemeManager.currentTheme().subtitleTextColor
                cell.messageLbl.textColor = ThemeManager.currentTheme().subtitleTextColor
                cell.dateLbl.textColor = ThemeManager.currentTheme().subtitleTextColor
                cell.backgroundColor = UIColor(named: "littelYellow")
                cell.dataCell(itemCellOnline)
                break
            case 1:
                let itemCellHistory = conversationListsHistory[indexPath.row]
                cell.backgroundColor = ThemeManager.currentTheme().backgroundColor
                cell.nameLbl.textColor = ThemeManager.currentTheme().titleTextColor
                cell.messageLbl.textColor = ThemeManager.currentTheme().titleTextColor
                cell.dateLbl.textColor = ThemeManager.currentTheme().titleTextColor
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
        
        conversationLists.removeAll()
        conversationListsOnline.removeAll()
        conversationListsHistory.removeAll()
        
        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        
        let item = ConversationList(name: "Вася", message: "Привет, как дела?", date: dateFormatter.date(from: "2019-01-01 01:11:01"), online: false, hasUnreadMessage: true)
        let item1 = ConversationList(name: "Петя", message: "Дай телефон Звезды", date: Date(), online: true, hasUnreadMessage: false)
        let item3 = ConversationList(name: "Дима", message: "Как дз? сделал?", date: dateFormatter.date(from: "2019-01-06 08:51:01"), online: false, hasUnreadMessage: true)
        let item4 = ConversationList(name: "Света", message: "Привет сладкий", date: Date(), online: true, hasUnreadMessage: true)
        let item5 = ConversationList(name: "Звезда", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-05 11:21:01"), online: false, hasUnreadMessage: false)
        let item6 = ConversationList(name: "Соня", message: nil, date: Date(), online: true, hasUnreadMessage: true)
        let item7 = ConversationList(name: "Звезда1", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-05 11:21:01"), online: false, hasUnreadMessage: false)
        let item8 = ConversationList(name: "Звезда2", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-15 11:21:01"), online: true, hasUnreadMessage: true)
        let item9 = ConversationList(name: "Звезда3", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-25 11:21:01"), online: false, hasUnreadMessage: false)
        let item10 = ConversationList(name: "Звезда4", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-04 11:21:01"), online: false, hasUnreadMessage: true)
        let item11 = ConversationList(name: "Звезда5", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-03 11:21:01"), online: true, hasUnreadMessage: false)
        let item12 = ConversationList(name: "Звезда6", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-11 11:21:01"), online: false, hasUnreadMessage: false)
        let item13 = ConversationList(name: "Звезда7", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-12 11:21:01"), online: false, hasUnreadMessage: false)
        let item14 = ConversationList(name: "Звезда8", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-15 11:21:01"), online: true, hasUnreadMessage: false)
        let item15 = ConversationList(name: "Звезда9", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-25 11:21:01"), online: false, hasUnreadMessage: false)
        let item16 = ConversationList(name: "Звезда10", message: "Гори гори моя звезда", date: dateFormatter.date(from: "2019-01-05 11:21:01"), online: false, hasUnreadMessage: false)
        let item17 = ConversationList(name: "Маша", message: "Привет ", date: Date(), online: true, hasUnreadMessage: true)
        let item18 = ConversationList(name: "Даша", message: "Привет ", date: Date(), online: true, hasUnreadMessage: true)
        let item19 = ConversationList(name: "Саша", message: "Привет ", date: Date(), online: true, hasUnreadMessage: true)
        let item20 = ConversationList(name: "ПростоМария", message: "Привет ", date: Date(), online: true, hasUnreadMessage: true)
        let item21 = ConversationList(name: "Кардебалет", message: "Привет ", date: Date(), online: true, hasUnreadMessage: true)
        
        conversationLists.append(item)
        conversationLists.append(item1)
        conversationLists.append(item3)
        conversationLists.append(item4)
        conversationLists.append(item5)
        conversationLists.append(item6)
        conversationLists.append(item7)
        conversationLists.append(item8)
        conversationLists.append(item9)
        conversationLists.append(item10)
        conversationLists.append(item11)
        conversationLists.append(item12)
        conversationLists.append(item13)
        conversationLists.append(item14)
        conversationLists.append(item15)
        conversationLists.append(item16)
        conversationLists.append(item17)
        conversationLists.append(item18)
        conversationLists.append(item19)
        conversationLists.append(item20)
        conversationLists.append(item21)

        
        for i in conversationLists {
            if i.online {
                conversationListsOnline.append(i)
            } else {
                conversationListsHistory.append(i)
            }
        }
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
}
