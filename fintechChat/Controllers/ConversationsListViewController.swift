//
//  ConversationsListViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 21/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ConversationsListViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    var conversationLists = [ConversationList]()
    var conversationListsOnline = [ConversationList]()
    var conversationListsHistory = [ConversationList]()
    var conversationData = [ConversationList]()
    var messageLists = [MessageLists]()
    
    //let messageService = MultiPeerCommunicator()
    //слияние газпрома и роснефти прошло успешно
    //а евро тем временем в инвестициях = 72.98
    
    
    let MessageServiceType = "tinkoff-chat"
    var myPeerId: MCPeerID!
    var session: MCSession!
    
    var fromUser: String?
    var fromUserPeer: MCPeerID!
    
    var serviceAdvertiser: MCNearbyServiceAdvertiser!
    var serviceBrowser: MCNearbyServiceBrowser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //messageService.delegate = self
        
        myPeerId = MCPeerID(displayName: UIDevice.current.name + "DmitryPyatin")
        
        //Делаем устройство видимым для других
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: MessageServiceType)
        //Ищем другие устройства
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: MessageServiceType)
        
        session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        //включаем видимость
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        
        //включаем поиск
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        loadData()
    }
    
    deinit {
       serviceAdvertiser.stopAdvertisingPeer()
       serviceBrowser.stopBrowsingForPeers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        session.delegate = self
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
            
            destination.messageLists = messageLists
            
            destination.fromUser = myPeerId.displayName
            destination.fromUserPeer = myPeerId
            
            destination.toUser = fromUserPeer.displayName
            destination.toUserPeer = fromUserPeer

            destination.session = session
            destination.conversationData = conversationData
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return section == 0 ? conversationListsOnline.count : conversationListsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ConversationTableViewCell {
            
            
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
        
        /*
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

        for i in conversationLists {
            if i.online {
                conversationListsOnline.append(i)
            } else {
                conversationListsHistory.append(i)
            }

        } */
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}


extension ConversationsListViewController : MCNearbyServiceAdvertiserDelegate {
    
    //Узнаем, что видимость не включилась
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("didNotStartAdvertisingPeer: \(error)")
    }
    
    
    //Получили приглашение
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
       print("didReceiveInvitationFromPeer \(peerID)")
        
        if session.connectedPeers.contains(peerID) {
            invitationHandler(false, nil)
        } else {
            invitationHandler(true, session)
        }
    }
}

extension ConversationsListViewController : MCNearbyServiceBrowserDelegate {
    //что то пошло не так
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("didNotStartBrowsingForPeers: \(error)")
    }
    
    
    //кого то нашли
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("нашли участника: \(peerID)")
        print("пригласили участника: \(peerID)")
        //зовем к себе
        
       // fromUserPeer = peerID  //это пир кто к нам подключился
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    
    //кто то пропал
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("потеряли участника: \(peerID)")
        

        if let index = conversationListsOnline.firstIndex(where: { $0.name == peerID.displayName }) {
            conversationListsHistory.append(conversationListsOnline[index])
            conversationListsOnline.remove(at: index)
        }

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}


extension ConversationsListViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        

        let indexHistory = conversationListsHistory.firstIndex(where: { $0.name == peerID.displayName })

        if state.rawValue == 2 {
            print("участник \(peerID) изменил состояние: \(state.rawValue)")
            fromUserPeer = peerID
            if self.conversationListsOnline.contains(where: { $0.name == peerID.displayName }) {
                if (indexHistory != nil) {
                    
                    conversationListsHistory.remove(at: indexHistory!)
                }
            } else {
                if (indexHistory != nil) {
                    conversationListsOnline.append(conversationListsHistory[indexHistory!])
                    conversationListsHistory.remove(at: indexHistory!)
                } else {
                let item = ConversationList(name: peerID.displayName, message: nil, date: Date(), online: true, hasUnreadMessage: true)
                self.conversationListsOnline.append(item)
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("22222didReceiveData222222: \(data)")
        let str = String(data: data, encoding: .utf8)!
        print(str)
        let index = conversationListsOnline.firstIndex(where: { $0.name == peerID.displayName })
        
        if str.count > 0 {
            //убираем из массива, чтобы видеть последнее сообщение 
            self.conversationListsOnline.remove(at: index!)
            let itemMessage = MessageLists(text: str ,fromUser: peerID.displayName, toUser: myPeerId.displayName )
            let item = ConversationList(name: peerID.displayName, message: str, date: Date(), online: true, hasUnreadMessage: true)
            self.messageLists.append(itemMessage)
            self.conversationListsOnline.append(item)
        }
        DispatchQueue.main.async {
            self.conversationListsOnline.sort(by: { $0.date!.compare($1.date!) == .orderedDescending })
            self.tableView.reloadData()
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print("didFinishReceivingResourceWithName")
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
}
