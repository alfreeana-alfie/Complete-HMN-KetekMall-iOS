//
//  ChatInboxViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 08/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire


class ChatInboxViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var UserID: String = ""
    
    var USERNAME: [String] = []
    var USERIMAGE: [String] = []
    
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"

    @IBOutlet weak var ChatView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChatView.delegate = self
        ChatView.dataSource = self
        
        
    }
    
    func ChatList(){
        Alamofire.request(URL_MESSAGE, method: .get).responseJSON
            {
                response in
                switch response.result {
                case .success(let data):
                        debugPrint("\n Success: \(data)")
                case .failure(let error):
                    debugPrint("\n Failure: \(error.localizedDescription)")
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return USERNAME.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatInboxCollectionViewCell", for: indexPath) as! ChatInboxCollectionViewCell
        
        return cell
    }

}
