//
//  ViewSellingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ViewSellingViewController: UIViewController {

    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var Item_Name: UILabel!
    @IBOutlet weak var Item_Price: UILabel!
    @IBOutlet weak var Date_Order: UILabel!
    @IBOutlet weak var Ship_Place: UILabel!
    @IBOutlet weak var Status: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    
    @IBOutlet weak var Customer_Name: UILabel!
    @IBOutlet weak var Customer_Address: UITextView!
    @IBOutlet weak var Customer_Phone: UILabel!
    
    @IBOutlet weak var Tracking_No: UITextField!
    @IBOutlet weak var ButtonSubmit: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    
    
    let URL_READ_CUSTOMER = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_tracking_no.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_reject.php"
    
    var ItemID = ""
    var USERID: String = ""
    var CUSTOMERID: String = ""
    var ORDERID: String = ""
    var ITEMIMAGE: String = ""
    var ITEMNAME: String = ""
    var ITEMPRICE: String = ""
    var DATEORDER: String = ""
    var SHIPPLACED: String = ""
    var STATUS: String = ""
    var QUANTITY: String = ""
    var ORDER_DATE: String = ""
    var TRACKINGNO: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ItemID)
        
        OrderID.text! = ORDERID
        Item_Name.text! = ITEMNAME
        Item_Price.text! = ITEMPRICE
        Date_Order.text! = DATEORDER
        Ship_Place.text! = SHIPPLACED
        Status.text! = STATUS
        Quantity.text! = QUANTITY
        Tracking_No.text! = TRACKINGNO
        
        ButtonSubmit.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        
        getUserDetails()
        
        
    }
    
    func getUserDetails(){
        let parameters: Parameters=[
            "id": CUSTOMERID
        ]
        
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let email = user.value(forKey: "email") as! [String]
                        let district = user.value(forKey: "division") as! [String]
                        let Phone = user.value(forKey: "phone_no") as! [String]
                        
                        self.Customer_Name.text = name[0]
                        self.Customer_Address.text! = district[0]
                        self.Customer_Phone.text! = Phone[0]
                        
                        self.sendEmail(Email: email[0], OrderID: self.ORDERID)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func sendEmail(Email: String, OrderID: String){
        let parameters: Parameters=[
            "email": Email,
            "order_id": OrderID
        ]

        Alamofire.request(URL_SEND, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
        }
    }

    @IBAction func Submit(_ sender: Any) {
        let parameters: Parameters=[
                            "order_date": ORDER_DATE,
                            "tracking_no": Tracking_No.text!
                        ]
                        
                        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value {
                                    let jsonData = result as! NSDictionary
                                    print(jsonData.value(forKey: "message")!)
                                    let boostAd = self.storyboard!.instantiateViewController(identifier: "MySellingViewController") as! MySellingViewController
                                    boostAd.userID = self.USERID
                                    if let navigator = self.navigationController {
                                        navigator.pushViewController(boostAd, animated: true)
                                    }
                                }else{
                                    print("FAILED")
                                }
                                
                        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
