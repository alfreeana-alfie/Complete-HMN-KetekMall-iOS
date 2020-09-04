//
//  AddReviewViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class AddReviewViewController: UIViewController {
    
    let URL_ADD = "https://ketekmall.com/ketekmall/add_review.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    
    @IBOutlet weak var Review: UITextView!
    @IBAction func Submit(_ sender: Any) {
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "customer_id": USERID,
            "customer_name": USERNAME,
            "item_id": ITEMID,
            "review": Review.text!,
            "rating": RATING,
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }else{
                    print("FAILED")
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
    }
    
    var USERNAME: String = ""
    var USERID: String = ""
    var SELLERID: String = ""
    var ITEMID: String = ""
    var RATING: String = "3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserDetails()
    }
    
    func getUserDetails(){
        let parameters: Parameters=[
            "id": USERID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        
                        self.USERNAME = name[0]
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
}
