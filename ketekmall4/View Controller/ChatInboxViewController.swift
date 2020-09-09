//
//  ChatInboxViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 08/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire


class ChatInboxViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ChatInboxDelegate {
    
    
    
    var UserID: String = ""
    var ChatWith: String = ""
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var email: String = ""
    var name: String = ""
    
    var USERNAME: [String] = []
    var USERIMAGE: [String] = []
    
    var NAME: String = ""
    var EMAILUSER: String = ""
    var CHATWITH: [String] = []
    
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"

    @IBOutlet weak var ChatView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        print(email)

        ChatView.delegate = self
        ChatView.dataSource = self
        let index = email.firstIndex(of: "@") ?? email.endIndex
        let newEmail = email[..<index]
        
        EMAILUSER = String(newEmail)
//        print("EMAIL: \(newEmail)")
        ChatList()
    }
    
    func ChatList(){
        Alamofire.request(URL_MESSAGE, method: .get).responseJSON
            {
                response in
                
                if let result = response.result.value{
                    let json = result as! [String: Any]
                    let Message = json.keys
                    let index = self.email.firstIndex(of: "@") ?? self.email.endIndex
                    let newEmail = self.email[..<index]
//                    let Username = "Admin"
                    
                    for i in Message{
                        if(i.contains(String(newEmail) + "_")){
                            print(i)
                            Alamofire.request(self.URL_USER, method: .get).responseJSON{
                                response1 in
                                if let resultUser = response1.result.value{
                                    
                                    if let jsonUser = resultUser as? [String: Any] {
                
                                        for j in jsonUser.keys{
                                            if let User1 = jsonUser[j] as? [String: Any]{
                                                for k in User1{
                                                    if(k.key == "email"){
                                                        let Email = String(describing: k.value)
                                                        let index2 = Email.firstIndex(of: "@") ?? Email.endIndex
                                                        let newEmail2 = Email[..<index2]
                                                        
                                                        if(!j.elementsEqual(self.name)){
                                                            if(i.contains(String(newEmail2))){
                                                                print("USER: \(j)")
                                                                
                                                            
                                                                self.USERNAME.append(j)
                                                                self.CHATWITH.append(String(newEmail2))
                                                                
                                                                self.ChatView.reloadData()
                                                            }
                                                        }
                                                        
                                                        if(j.elementsEqual(self.name)){
                                                            self.NAME = j
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
        }
    }
    
    func Pic(Chatwith: String){
        Alamofire.request(URL_USER, method: .get).responseJSON{
                        response1 in
                        if let resultUser = response1.result.value{
                            
                            if let jsonUser = resultUser as? [String: Any] {
        
                                for j in jsonUser.keys{
                                    if let User1 = jsonUser[j] as? [String: Any]{
                                        for k in User1{
                                            if(k.key == "photo"){
//                                                let Email = String(describing: k.value)
//                                                let index2 = Email.firstIndex(of: "@") ?? Email.endIndex
//                                                let newEmail2 = Email[..<index2]
                                                if(j.elementsEqual(Chatwith)){
                                                    let Photo = String(describing: k.value)
                                                    
                                                    self.USERIMAGE.append(Photo)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return USERNAME.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatInboxCollectionViewCell", for: indexPath) as! ChatInboxCollectionViewCell
        
        
        
        cell.Username.text! = self.USERNAME[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func onClick(cell: ChatInboxCollectionViewCell) {
        guard let indexPath = self.ChatView.indexPath(for: cell) else{
            return
        }
        
        let myBuying = self.storyboard!.instantiateViewController(identifier: "ChatViewController") as! ChatViewController
        myBuying.UserID = UserID
        myBuying.ChatWith = USERNAME[indexPath.row]
        myBuying.ChatWith1 = CHATWITH[indexPath.row]
        myBuying.EmailUser = EMAILUSER
        myBuying.NAME = NAME
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }

}
