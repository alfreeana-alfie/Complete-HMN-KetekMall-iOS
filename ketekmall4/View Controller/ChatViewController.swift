//
//  ChatViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 09/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import InputBarAccessoryView

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}



class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate {
    
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var name: String = ""
    var email: String = ""
    var chatWith: String = ""
    
    private var messages = [Message]()
    let randomString = String.random()
    var sender: SenderType = Sender(senderId: "", displayName: "")
    var other_user: SenderType = Sender(senderId: "", displayName: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        print(randomString)
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"

        sender = Sender(senderId: user, displayName: name)
        other_user = Sender(senderId: "4", displayName: "Nana")
        
        messages.append(Message(sender: sender, messageId: randomString, sentDate: Date(), kind: .text("Hellow World")))
        messages.append(Message(sender: other_user, messageId: randomString, sentDate: Date(), kind: .text("Hello World")))
        view.backgroundColor = .red
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else{
            return
        }
        messages.append(Message(sender: sender, messageId: randomString, sentDate: Date(), kind: .text(text)))
        messagesCollectionView.reloadDataAndKeepOffset()
        print("SENDING: \(text)")
    }
}


extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate{
    func currentSender() -> SenderType {
        return sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
