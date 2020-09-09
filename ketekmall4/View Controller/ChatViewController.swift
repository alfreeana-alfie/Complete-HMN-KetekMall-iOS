//
//  ChatViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 08/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var UserID: String = ""
    var ChatWith: String = ""
    var ChatWith1: String = ""
    var EmailUser: String = ""
    var NAME: String = ""
    
    var ChatWithContent: [String] = []
    var ChatWithContentUSER: [String] = []
    var ChatUser: [String] = []
    
    @IBOutlet var ChatView: UICollectionView!
    @IBOutlet weak var Message: UITextField!
    @IBOutlet weak var ButtonSend: UIButton!
    
    enum ItemType : Int {
        case items = 0,
             items2 = 1
    }
    
    var itemType : ItemType = .items
    
    @IBAction func Send(_ sender: Any) {
        
    }
    
    
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatView.dataSource = self
        ChatView.delegate = self
        
        let ref = FirebaseDatabase.Database.database().reference().child("messages").child(ChatWith1 + "_" + EmailUser)
        
//        let ref1 = FirebaseDatabase.Database.database().reference().child("messages").child(EmailUser + "_" + ChatWith1)
        
        ref.observe(.childAdded, with: {(DataSnapshot) in
            if let userDict = DataSnapshot.value as? [String:Any] {
                    let user = userDict["user"] as! String
                    let message = userDict["message"] as! String
//                    let time = userDict["time"] as! String
                    
//                print(user)
                if(user.elementsEqual(self.NAME)){
                    self.ChatWithContentUSER.append(message)
                    self.itemType = .items
                }
                self.ChatView.reloadData()
                    
                }
        })
        
        ref.observe(.childAdded, with: {(DataSnapshot) in
            if let userDict = DataSnapshot.value as? [String:Any] {
                let user = userDict["user"] as! String
                let message = userDict["message"] as! String
//                let time = userDict["time"] as! String
                
//                print(user)
                if(user.elementsEqual(self.ChatWith)){
                    self.itemType = .items2
                    self.ChatWithContent.append(message)
                }
                self.ChatView.reloadData()
                
            }
        })
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch itemType {
        case .items:
            return ChatWithContentUSER.count
        case .items2:
            return ChatWithContent.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCollectionViewCell", for: indexPath) as! ChatCollectionViewCell
        
        switch itemType {
        case .items:
            cell.Message.text! = self.ChatWithContentUSER[indexPath.row]
            cell.Message.backgroundColor = UIColor.orange
            print("CH1A" + String(self.ChatWithContentUSER.count))
        case .items2:
           cell.Message.text! = self.ChatWithContent[indexPath.row]
           cell.Message.backgroundColor = UIColor.green
           print("CHA" + String(self.ChatWithContentUSER.count))
        }
        return cell
    }

}
