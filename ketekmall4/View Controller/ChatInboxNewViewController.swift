//
//  ChatInboxNewViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 08/01/2021.
//  Copyright © 2021 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ChatInboxNewViewController: UIViewController{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if(self.ChatCount.count == 0){
//            return 1
//        }else{
//            return self.ChatCount.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
    
    let URL_GETCHAT = "https://ketekmall.com/ketekmall/getChat.php"
    let URL_GETCHATISREAD = "https://ketekmall.com/ketekmall/getChatIsRead.php"
    
    var UserPhoto: [String] = []
    var ChatWith: [String] = []
    var ChatWithID: [String] = []
    var ChatWithPhoto: [String] = []
    var ChatCount: [String] = []
    
    let sharedPref = UserDefaults.standard
    var UserID: String = ""
    var Name: String = ""
    
    @IBOutlet weak var ChatView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func getChat(){
        let parameters: Parameters=[
            "UserID": UserID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_GETCHAT, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
//                        let Name = user.value(forKey: "Name") as! [String]
//                        let UserPhoto = user.value(forKey: "UserPhoto") as! [String]
                        let ChatWith = user.value(forKey: "ChatWith") as! [String]
                        let ChatWithID = user.value(forKey: "ChatWithID") as! [String]
                        let ChatWithPhoto = user.value(forKey: "ChatWithPhoto") as! [String]
                        
                        self.ChatWith = ChatWith
                        self.ChatWithID = ChatWithID
                        self.ChatWithPhoto = ChatWithPhoto
                        
                        for i in 0..<self.ChatWithID.count{
                            let parametersInner: Parameters=[
                                "UserID": self.UserID,
                                "ChatWithID": self.ChatWithID[i]
                            ]
                            
                            Alamofire.request(self.URL_GETCHATISREAD, method: .post, parameters: parametersInner).responseJSON
                            {
                                responseInner in
                                
                                if let resultInner = responseInner.result.value{
                                    let jsonDataInner = resultInner as! NSDictionary
                                    let Success = jsonDataInner.value(forKey: "success") as! NSString
                                    
                                    if(Success.boolValue){
                                        let DataInner = jsonDataInner.value(forKey: "read") as! NSArray
                                        let ChatCount = DataInner.count
                                        
                                        self.ChatCount.append(String(ChatCount))
                                        
                                    }else{
                                        print("Failed to retrieve!")
                                    }
                                }
                            }
                        }
                    }
                }
        }
    }
    
    

}
