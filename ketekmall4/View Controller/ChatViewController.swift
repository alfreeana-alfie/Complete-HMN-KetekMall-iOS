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
import FirebaseInstanceID

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
    let URL_ADD_CHAT = "https://ketekmall.com/ketekmall/add_chat.php"
    let URL_EDIT_CHAT = "https://ketekmall.com/ketekmall/edit_chat.php"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    
    let URL_CREATECHAT = "https://ketekmall.com/ketekmall/createChat.php"
    let URL_GETCHATSINGLE = "https://ketekmall.com/ketekmall/getChatSingle.php"
    let URL_GETCHAT = "https://ketekmall.com/ketekmall/getChat.php"
    let URL_UPDATECHAT = "https://ketekmall.com/ketekmall/updateChat.php"
    
    let ref = Database.database().reference(withPath: "messages")
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var name: String = ""
    var email: String = ""
    var chatWith: String = ""
    var chatName: String = ""
    var chatToken: String = ""
    var emailUser: String = ""
    var messageSaved: String = ""
    
    var ChatID: String = ""
    var ChatUserName: String = ""
    
    // Chat Variable
    var UserPhoto: String = ""
    var chatWithV: String = ""
    var chatWithID: String = ""
    var chatWithPhoto: String = ""
    
    var TypeChat: [String] = []
    
    var saved: [String] = []
    let newArr: [String] = []
    var list = [Saved]()
    
    let senderNotification = PushNotificationSender()
    var tokenUser: String = ""
    
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
        other_user = Sender(senderId: "2", displayName: chatWithV)
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self

        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
        layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
        
//        print("\(UserPhoto)")
        
        getChat()
//        UpdateChat()
        
//        UpdateChatData(user_chatWith: ref1)
//        ChatList2()
//        ChatNew()
    }
    
    func getChat(){
        let parameters: Parameters=[
            "UserID": user,
            "ChatWithID": chatWithID
        ]
        
        Alamofire.request(URL_GETCHATSINGLE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ID = user.value(forKey: "id") as! [String]
                        let Content = user.value(forKey: "Content") as! [String]
                        let CreatedDateTime = user.value(forKey: "CreatedDateTime") as! [String]
                        let Type = user.value(forKey: "Type") as! [String]
                        
                        let date = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "nl_NL")
                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT 8")
                        dateFormatter.dateFormat = "MMMM-dd-yyyy HH:mm"
                        
                        self.TypeChat = Type
                        for i in 0..<self.TypeChat.count{
                            if(self.TypeChat[i] == "1"){
                                self.messages.append(Message(sender: self.sender, messageId: ID[i], sentDate: date, kind: .text(Content[i])))
                            }else{
                                self.messages.append(Message(sender: self.other_user, messageId: ID[i], sentDate: date, kind: .text(Content[i])))
                            }
                            self.messagesCollectionView.reloadData()
                        }
                       
                    }
                    print("CHAT SUCCESS")
                }else{
                    print("FAILED")
                }
        }
    }
    
    func createChat(MessageText: String){
        let parameters: Parameters=[
            "Name": self.name,
            "UserID": self.user,
            "UserPhoto": UserPhoto,
            "ChatWith": chatWithV,
            "ChatWithID": chatWithID,
            "ChatWithPhoto": chatWithPhoto,
            "Content": MessageText,
            "IsRead": "true",
            "Type": "1"
        ]
        
        Alamofire.request(URL_CREATECHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SAVED!")
                    }
                    print("CHAT SUCCESS")
                }else{
                    print("FAILED")
                }
        }
    }
    
    func createChatWith(MessageTextWith: String){
        let parameters: Parameters=[
            "Name": chatWithV,
            "UserID": chatWithID,
            "UserPhoto": chatWithPhoto,
            "ChatWith": self.name,
            "ChatWithID": self.user,
            "ChatWithPhoto": self.UserPhoto,
            "Content": MessageTextWith,
            "IsRead": "false",
            "Type": "2"
        ]
        
        Alamofire.request(URL_CREATECHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SAVED!")
                    }
                    print("CHAT SUCCESS")
                }else{
                    print("FAILED")
                }
        }
    }
    
    func UpdateChat(){
        let parameters: Parameters=[
            "Name": self.name,
            "UserID": self.user,
            "UserPhoto": UserPhoto,
            "ChatWithID": chatWithID,
            "IsRead": "true"
        ]
        
        Alamofire.request(URL_UPDATECHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SAVED!")
                    }
                    print("CHAT SUCCESS")
                }else{
                    print("FAILED")
                }
        }
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
        
        messages.append(Message(sender: sender, messageId: randomString, sentDate: date, kind: .text(text)))
        messagesCollectionView.reloadDataAndKeepOffset()
        
        self.createChat(MessageText: text)
        self.createChatWith(MessageTextWith: text)
        
        self.OneSignalNoti(PlayerID: ChatID, Name: self.name, MessageText: text)
        randomString = ""
        randomString = randomString2
        inputBar.inputTextView.text.removeAll()
    }
    
    private func ChatData(user_chatWith: String, chat_key: String){
        let parameters: Parameters=[
            "user_chatwith": user_chatWith,
            "chat_key": chat_key,
            "is_read": "false"
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD_CHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }
        }
    }
    
    private func UpdateChatData(user_chatWith: String){
        let parameters: Parameters=[
            "user_chatwith": user_chatWith,
            "is_read": "true"
        ]
        
        //Sending http post request
        Alamofire.request(URL_EDIT_CHAT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }
        }
    }
    
    func GetPlayerData(SellerID: String, MessageText: String, CustomerID: String){
        let parameters: Parameters=[
            "UserID": SellerID
        ]
        
        Alamofire.request(URL_GET_PLAYERID, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let PlayerID = user.value(forKey: "PlayerID") as! [String]
                        let Name = user.value(forKey: "Name") as! [String]
                        _ = user.value(forKey: "UserID") as! [String]
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func OneSignalNoti(PlayerID: String, Name: String, MessageText: String){
        let parameters: Parameters=[
            "PlayerID": PlayerID,
            "Name": Name,
            "Words": Name + ": " + MessageText
        ]
        
        Alamofire.request(URL_NOTI, method: .post, parameters: parameters).responseJSON
            {
                response in
            if response.result.value != nil{
                    print("ONESIGNAL SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
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
