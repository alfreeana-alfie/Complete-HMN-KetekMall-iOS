//
//  ViewSellingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ViewSellingViewController: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
    
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
    
    @IBOutlet weak var PosLabel: UILabel!
    
    
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
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    @IBOutlet weak var Ordered: UILabel!
    @IBOutlet weak var Pending: UILabel!
    @IBOutlet weak var Shipped: UILabel!
    @IBOutlet weak var Received: UILabel!
    
    @IBOutlet weak var Ordered_Black: UIImageView!
    @IBOutlet weak var Pending_Black: UIImageView!
    @IBOutlet weak var Shipped_Black: UIImageView!
    @IBOutlet weak var Received_Black: UIImageView!
    
    @IBOutlet weak var Ordered_Green: UIImageView!
    @IBOutlet weak var Pending_Green: UIImageView!
    @IBOutlet weak var Shipped_Green: UIImageView!
    @IBOutlet weak var Received_Green: UIImageView!
    
    @IBOutlet weak var Finished: UILabel!
    @IBOutlet weak var FinishedHeight: NSLayoutConstraint!
    
    @IBOutlet weak var PosLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var TrackingHeight: NSLayoutConstraint!
    @IBOutlet weak var SubmitHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(ItemID)
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        OrderID.text! = "KM" + ORDERID
        Item_Name.text! = ITEMNAME
        Item_Price.text! = "MYR" + ITEMPRICE
        Date_Order.text! = "Order Placed on" + DATEORDER
        Ship_Place.text! = "Shipped out to" + SHIPPLACED
        Status.text! = STATUS
        Quantity.text! = "x" + QUANTITY
        Tracking_No.text! = TRACKINGNO
        
        ButtonSubmit.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        
        if(STATUS == "Ordered"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending_Green.isHidden = true
            Shipped_Green.isHidden = true
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Pending"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
            Shipped_Green.isHidden = true
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Shipped"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
            Shipped.textColor = .green
            Shipped_Black.isHidden = true
            Shipped_Green.isHidden = false
            
            Received_Green.isHidden = true
            
            Finished.isHidden = true
            FinishedHeight.constant = 0
        }else if(STATUS == "Received"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
            Pending.textColor = .green
            Pending_Black.isHidden = true
            Pending_Green.isHidden = false
            
            Shipped.textColor = .green
            Shipped_Black.isHidden = true
            Shipped_Green.isHidden = false
            
            Received.textColor = .green
            Received_Black.isHidden = true
            Received_Green.isHidden = false
            
            Finished.isHidden = false
        }else if(STATUS == "Reject"){
            
            Ordered_Black.isHidden = false
            Ordered_Green.isHidden = true
            
            
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
            
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
            
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.backgroundColor = .red
            Finished.text = "REJECT"
            
            PosLabel.isHidden = true
            PosLabelHeight.constant = 0
            Tracking_No.isHidden = true
            TrackingHeight.constant = 0
            ButtonSubmit.isHidden = true
            SubmitHeight.constant = 0
            
        }else if(STATUS == "Cancel"){
            
            Ordered_Black.isHidden = false
            Ordered_Green.isHidden = true
            
            
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
            
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
            
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            Finished.backgroundColor = .red
            Finished.text = "CANCEL"
            
            PosLabel.isHidden = true
            PosLabelHeight.constant = 0
            Tracking_No.isHidden = true
            TrackingHeight.constant = 0
            ButtonSubmit.isHidden = true
            SubmitHeight.constant = 0
        }
        
        
        getUserDetails()
        
        
    }
    
    func changeLanguage(str: String){
        ButtonSubmit.titleLabel?.text = "SUBMIT".localized(lang: str)
        ButtonCancel.titleLabel?.text = "Cancel".localized(lang: str)
    }
    
    func getUserDetails(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "id": CUSTOMERID
        ]
        
        Alamofire.request(URL_READ_CUSTOMER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
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
        spinner.show(in: self.view)
        let parameters: Parameters=[
                            "order_date": ORDER_DATE,
                            "tracking_no": Tracking_No.text!
                        ]
                        
                        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value {
                                    let jsonData = result as! NSDictionary
                                    self.spinner.dismiss(afterDelay: 3.0)
                                    let boostAd = self.storyboard!.instantiateViewController(identifier: "MySellingViewController") as! MySellingViewController
                                    boostAd.userID = self.USERID
                                    if let navigator = self.navigationController {
                                        navigator.pushViewController(boostAd, animated: true)
                                    }
                                }else{
                                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                                    self.spinner.textLabel.text = "Failed"
                                    self.spinner.show(in: self.view)
                                    self.spinner.dismiss(afterDelay: 4.0)
                                }
                                
                        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
