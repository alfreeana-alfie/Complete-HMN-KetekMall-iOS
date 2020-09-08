//
//  ViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 05/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var Segment: UISegmentedControl!
    @IBOutlet weak var BuyerView: UIView!
    @IBOutlet weak var SellerView: UIView!
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var verify: UILabel!
    var userID: String = ""
    
    let sharedPref = UserDefaults.standard
    var user: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = sharedPref.string(forKey: "USERID") ?? "0"
        userID = String(user)
        
        let parameters: Parameters=[
            "id": userID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let verify = user.value(forKey: "verification") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.username.text = name[0]
                        if verify[0] == "1" {
                            self.verify.text = "SELLER"
                        }else{
                            self.verify.text = "BUYER"
                        }
                        
                        self.userImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    @IBAction func SegmentClick(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            BuyerView.alpha = 1
            SellerView.alpha = 0
            break
            
        case 1:
            SellerView.alpha = 1
            BuyerView.alpha = 0
            break
            
        default:
            break
        }
    }
}
