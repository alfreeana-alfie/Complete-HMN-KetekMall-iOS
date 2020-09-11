//
//  ChatInboxViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 09/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ChatInboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ChatView: UITableView!
    
//    private let noChat: UILabel = {
//        let label = UILabel()
//        label.text! = "no chat"
//        label.textAlignment = .center
//        label.textColor = .gray
//       return label
//    }()
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var name: String = ""
    var email: String = ""
    
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"
    
    var USERNAME: [String] = []
    var USERIMAGE: [String] = []
    
    var NAME: String = ""
    var EMAILUSER: String = ""
    var CHATWITH: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ChatView.delegate = self
        ChatView.dataSource = self
        
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        let index = email.firstIndex(of: "@") ?? email.endIndex
        let newEmail = email[..<index]
        
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
                        
                        for i in Message{
                            if(i.contains(String(newEmail) + "_")){
                                print(i)
                                Alamofire.request(self.URL_USER, method: .get).responseJSON{
                                    response1 in
                                    if let resultUser = response1.result.value{
                                        if let jsonUser = resultUser as? [String: Any] {
                                            for j in jsonUser.keys{
                                                if let User1 = jsonUser[j] as? [String: Any]{
                                                    let email = User1["email"] as! String
//                                                    let photo = User1["photo"] as! String
                                                    
                                                    let index2 = email.firstIndex(of: "@") ?? email.endIndex
                                                    let newEmail2 = email[..<index2]
                                                    
                                                    if(!j.elementsEqual(self.name)){
                                                        if(i.contains(String(newEmail2))){
                                                        
                                                            self.USERNAME.append(j)
                                                            self.CHATWITH.append(String(newEmail2))
                                                            
                                                            self.ChatView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return USERNAME.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.UserName.text! = self.USERNAME[indexPath.row]
        cell.accessoryType = .detailDisclosureButton
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ChatViewController()
        vc.title = self.USERNAME[indexPath.row]
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}