//
//  DeliveryAddViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 03/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class DeliveryAddViewController: UIViewController {

    
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Days: UITextField!
    
    
    @IBAction func Add(_ sender: Any) {
        let parameters: Parameters=[
            "user_id": USERID,
            "division": Division.text!,
            "price": Price.text!,
            "days": Days.text!,
            "item_id": ITEMID
            
        ]
        
        Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                     print("SUCCESS")
                    let parameters: Parameters=[
                        "id": self.ITEMID
                    ]
                    
                    Alamofire.request(self.URL_EDIT_DEL_STATUS, method: .post, parameters: parameters).responseJSON
                        {
                            response in
                            if let result = response.result.value{
                                let jsonData = result as! NSDictionary
                                
                                 print("SUCCESS EDIT STATUS")
                            }else{
                                print("FAILED")
                            }
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
    }
    
    var USERID: String = ""
    var ITEMID: String = ""
    var ADDETAIL: String = ""
    var DIVISION: String = ""
    var DAYS: String = ""
    var PRICE: String = ""
    
    let URL_ADD = "https://ketekmall.com/ketekmall/add_delivery_partone.php"
    let URL_EDIT_DEL_STATUS = "https://ketekmall.com/ketekmall/edit_delivery_status.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Division.text! = DIVISION
        Days.text! = DAYS
        Price.text! = PRICE
    }

}
