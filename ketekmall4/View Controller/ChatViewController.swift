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
import FirebaseDatabase
import FirebaseCore
import Alamofire

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

struct Saved {
    var messageID: String
    var message: String
    var time: String
    var user: String
}

class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate{
    
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"
    let ref = Database.database().reference(withPath: "messages")
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var name: String = ""
    var email: String = ""
    var chatWith: String = ""
    var chatName: String = ""
    var emailUser: String = ""
    var messageSaved: String = ""
    
    var saved: [String] = []
    let newArr: [String] = []
    var list = [Saved]()
    
    private var messages = [Message]()
    var randomString = String.random()
    var sender: SenderType = Sender(senderId: "", displayName: "")
    var other_user: SenderType = Sender(senderId: "", displayName: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"

        sender = Sender(senderId: "1", displayName: name)
        other_user = Sender(senderId: "2", displayName: chatWith)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self

        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
        ChatList2()
        ChatNew()
        
        let noti = UNMutableNotificationContent()
        noti.title = "Ketekmall"
        noti.body = "new messages"
    }
    
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else{
            return
        }
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "nl_NL")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT 8")
        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
        var randomString2 = String.random()
        
        
        let newDate = dateFormatter.string(from: date)
        messages.append(Message(sender: sender, messageId: randomString, sentDate: date, kind: .text(text)))
        messagesCollectionView.reloadDataAndKeepOffset()
        
        let msgSender_firebase = self.ref.child(emailUser + "_" + chatWith).child(randomString).child("message")
        let timeSender_firebase = self.ref.child(emailUser + "_" + chatWith).child(randomString).child("time")
        let userSender_firebase = self.ref.child(emailUser + "_" + chatWith).child(randomString).child("user")

        let msgReceiver_firebase = self.ref.child(chatWith + "_" + emailUser).child(randomString).child("message")
        let timeReceiver_firebase = self.ref.child(chatWith + "_" + emailUser).child(randomString).child("time")
        let userReceiver_firebase = self.ref.child(chatWith + "_" + emailUser).child(randomString).child("user")

        msgSender_firebase.setValue(text) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        timeSender_firebase.setValue(newDate) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        userSender_firebase.setValue(name) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        msgReceiver_firebase.setValue(text) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        timeReceiver_firebase.setValue(newDate) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }

        userReceiver_firebase.setValue(name) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        
        randomString = ""
        randomString = randomString2
        inputBar.inputTextView.text.removeAll()
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
    
    func ChatList2(){
        Alamofire.request(URL_MESSAGE, method: .get).responseJSON
            {
                response in
                if let result = response.result.value{
                    let index = self.email.firstIndex(of: "@") ?? self.email.endIndex
                    let newEmail = self.email[..<index]
                    
                    
                    if let jsonUser = result as? [String: Any]{
                        for i in jsonUser.keys{
                            if(i.elementsEqual(String(newEmail) + "_" + self.chatWith)){
                                if let User = jsonUser[i] as? [String: Any]{
                                    for j in User.keys{
                                        if let User1 = User[j] as? [String: Any] {
                                            let name = User1["user"] as? String
                                            let message = User1["message"] as? String
                                            let time = User1["time"] as? String
                                            
                                            self.saved.append(time!)
                                            let newlist = Saved(messageID: j, message: message!, time: time!, user: name!)
                                            self.list.append(newlist)
                                        }
                                        
                                    }
                                    self.ChatNew()
                                }
                            }
                            
                        }
                    }
                }
        }
    }
    
    func ChatNew(){
        let newarr = self.list.sorted { (pr1: Saved, pr2: Saved) -> Bool in
            return pr1.time < pr2.time
        }
        
        for k in newarr{
            let newID = k.messageID
            let newMessage = k.message
            let newTime = k.time
            let newUser = k.user
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "nl_NL")
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT 8")
            dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
            
            let newDate = dateFormatter.date(from: newTime)
            if(newUser.elementsEqual(self.name)){
                self.messages.append(Message(sender: self.sender, messageId: newID, sentDate: newDate ?? Date(), kind: .text(newMessage)))
            }else{
                self.messages.append(Message(sender: self.other_user, messageId: newID, sentDate:  newDate ?? Date(), kind: .text(newMessage)))
            }
            self.messagesCollectionView.reloadDataAndKeepOffset()
        }
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
