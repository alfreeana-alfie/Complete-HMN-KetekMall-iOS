//
//  ReviewPageViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ReviewPageViewController: UIViewController {
    
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_remarks_done.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_received.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    
    var itemID = ""
    var USERID = ""
    var ORDERID: String = ""
    var TRACKINGNO: String = ""
    var SHIPPEDTO: String = ""
    var DATEORDER: String = ""
    var DATERECEIVED: String = ""
    var ADDETAIL: String = ""
    var PRICE: String = ""
    var QUANTITY: String = ""
    var PHOTO: String = ""
    var SHIPPINGTOTAL: String = ""
    var SELLERID: String = ""
    
    @IBOutlet weak var OrderID: UILabel!
    @IBOutlet weak var TrackingNo: UILabel!
    @IBOutlet weak var ShippedTo: UILabel!
    @IBOutlet weak var DateOrder: UILabel!
    @IBOutlet weak var DateReceived: UILabel!
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemQuantity: UILabel!
    @IBOutlet weak var SubTotal: UILabel!
    @IBOutlet weak var ShippingTotal: UILabel!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var ButtonReceived: UIButton!
    
    @IBAction func Received(_ sender: Any) {
        let parameters: Parameters=[
            "order_date": DATEORDER,
        ]
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SUCCESS")
                        
                        self.getSellerDetails(SellerID: self.SELLERID, OrderID: self.ORDERID)
                        
                        let ReviewProduct = self.storyboard!.instantiateViewController(identifier: "AddReviewViewController") as! AddReviewViewController                        
                        ReviewProduct.USERID = self.USERID
                        ReviewProduct.ITEMID = self.itemID
                        ReviewProduct.SELLERID = self.SELLERID
                        if let navigator = self.navigationController {
                            navigator.pushViewController(ReviewProduct, animated: true)
                        }
                    }
                }
        }
    }
    
    func getSellerDetails(SellerID: String, OrderID: String){
        let parameters: Parameters=[
            "id": SELLERID,
        ]
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let SellerEmail = user.value(forKey: "email") as! [String]
                        
//                        self.SellerEmail = SellerEmail[0]
                        
                        self.sendEmail(Email: SellerEmail[0], OrderID: OrderID)
                    }
                }
        }
    }
    
    func sendEmail(Email: String, OrderID: String){
        let parameters: Parameters=[
            "email": Email,
            "order_id": OrderID
        ]
        
        //Sending http post request
        Alamofire.request(URL_SEND, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
//                        let user = jsonData.value(forKey: "read") as! NSArray
                        print("SENT")
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(itemID)
        
        OrderID.text! = ORDERID
        TrackingNo.text! = TRACKINGNO
        ShippedTo.text! = SHIPPEDTO
        DateOrder.text! = DATEORDER
        DateReceived.text! = DATERECEIVED
        
        ItemName.text! = ADDETAIL
        ItemPrice.text! = PRICE
        ItemQuantity.text! = QUANTITY
        
        SubTotal.text! = PRICE
        ShippingTotal.text! = SHIPPINGTOTAL
        GrandTotal.text! = PRICE
        
        ButtonReceived.layer.cornerRadius = 5
        
    }
}
