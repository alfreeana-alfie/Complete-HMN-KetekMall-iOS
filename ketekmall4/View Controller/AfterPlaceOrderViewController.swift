//
//  AfterPlaceOrderViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class AfterPlaceOrderViewController: UIViewController {
    
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_order_buyer.php"
    
    var userID: String = ""
    
    @IBAction func ContinueShopping(_ sender: Any) {
        let parameters: Parameters=[
            "customer_id": userID
        ]
        
        Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let boostAd = self.storyboard!.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                        boostAd.userID = self.userID
                        if let navigator = self.navigationController {
                            navigator.pushViewController(boostAd, animated: true)
                        }
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
