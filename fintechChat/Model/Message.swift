//
//  Message.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 19/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import Foundation

class Message: Codable {
    var eventType: String
    var text: String
    var messageId: String
    
    init(text: String) {
        self.text = text
        self.eventType = "TextMessage"
        self.messageId = Message.generateMessageId()
    }
    
    init(text: String, messageId: String, eventType: String = "TextMessage") {
        self.text = text
        self.messageId = messageId
        self.eventType = eventType
    }
    
    required init?(coder messageDecoder: NSCoder) {
        self.eventType = (messageDecoder.decodeObject(forKey: "eventType") as? String) ?? ""
        self.messageId = (messageDecoder.decodeObject(forKey: "messageId") as? String) ?? ""
        self.text = (messageDecoder.decodeObject(forKey: "text") as? String) ?? ""
    }
    
    func encode(with enCoder: NSCoder) {
        enCoder.encode(eventType, forKey: "eventType")
        enCoder.encode(messageId, forKey: "messageId")
        enCoder.encode(text, forKey: "text")
    }
    
    
    public static func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)!.base64EncodedString()
        return string
    }
}
