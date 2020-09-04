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
    @IBOutlet weak var Customer_Phone: UITextView!
    
    @IBOutlet weak var Tracking_No: UITextField!
    
    @IBAction func Submit(_ sender: Any) {
        let parameters: Parameters=[
                            "order_date": ORDER_DATE,
                            "tracking_no": Tracking_No.text!
                        ]
                        
                        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
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
    
    let URL_READ_CUSTOMER = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_tracking_no.php"
    
    var ItemID = ""
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
//        ItemImage.setImageWith(URL(string: ITEMIMAGE)!)
        Item_Name.text! = ITEMNAME
        Item_Price.text! = ITEMPRICE
        Date_Order.text! = DATEORDER
        Ship_Place.text! = SHIPPLACED
        Status.text! = STATUS
        Quantity.text! = QUANTITY
        Tracking_No.text! = TRACKINGNO
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
                        let district = user.value(forKey: "division") as! [String]
//                        let Photo = user.value(forKey: "photo") as! [String]
                        let Phone = user.value(forKey: "phone_no") as! [String]
                        
                        self.Customer_Name.text = name[0]
                        self.Customer_Address.text! = district[0]
                        self.Customer_Phone.text! = Phone[0]
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }

}
