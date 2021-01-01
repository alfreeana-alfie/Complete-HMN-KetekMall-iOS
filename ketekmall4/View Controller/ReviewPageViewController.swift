//
//  ReviewPageViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ReviewPageViewController: UIViewController, UITabBarDelegate {
    
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_remarks_done.php"
    let URL_SEND = "https://ketekmall.com/ketekmall/sendEmail_product_received.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_GET_PLAYERID = "https://ketekmall.com/ketekmall/getPlayerID.php"
    let URL_NOTI = "https://ketekmall.com/ketekmall/onesignal_noti.php"
    
    private let spinner = JGProgressHUD(style: .dark)
    let sharedPref = UserDefaults.standard
    var lang: String = ""

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
    var STATUS: String = ""
    var SELLER_DIVISION: String = ""
    var viewController1: UIViewController?
    
    var Total1: Double = 0.00
    var Total2: Double = 0.00
    
    @IBOutlet weak var OrderLable: UILabel!
    @IBOutlet weak var TrackingLabel: UILabel!
    @IBOutlet weak var ClickLabel: UILabel!
    @IBOutlet weak var ShippedLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var DateReceivedLabel: UILabel!
    @IBOutlet weak var SubTotalLabel: UILabel!
    @IBOutlet weak var ShippingTotalLabel: UILabel!
    @IBOutlet weak var GrandTotalLabel: UILabel!
    
    
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
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var BarHeight: NSLayoutConstraint!
    var BarHidden: Bool = false
    
    @IBAction func Received(_ sender: Any) {
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "order_date": DATEORDER,
            "delivery_price": SHIPPINGTOTAL
        ]
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                        self.spinner.textLabel.text = "Success"
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 4.0)
                        
                        self.getSellerDetails(SellerID: self.SELLERID, OrderID: self.ORDERID)
                        
                        self.GetPlayerData(CustomerID: self.SELLERID, OrderID: self.ORDERID)
                        
                        let ReviewProduct = self.storyboard!.instantiateViewController(withIdentifier: "AddReviewViewController") as! AddReviewViewController                        
                        ReviewProduct.USERID = self.USERID
                        ReviewProduct.ITEMID = self.itemID
                        ReviewProduct.SELLERID = self.SELLERID
                        if let navigator = self.navigationController {
                            navigator.pushViewController(ReviewProduct, animated: true)
                        }
                    }else{
                        self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                        self.spinner.textLabel.text = "Failed"
                        self.spinner.show(in: self.view)
                        self.spinner.dismiss(afterDelay: 4.0)
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
                        print("SENT")
                    }else{
                        print("FAILED")
                    }
                }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        
        if(BarHidden == true){
            Tabbar.isHidden = true
            BarHeight.constant = 0
        }else{
            Tabbar.isHidden = false
        }
        
        OrderID.text! = "KM" + ORDERID
        TrackingNo.text! = TRACKINGNO
        ShippedTo.text! = SHIPPEDTO
        DateOrder.text! = DATEORDER
        DateReceived.text! = DATERECEIVED
        let NEWIm = PHOTO.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        ItemName.text! = ADDETAIL
        ItemPrice.text! = "MYR" + PRICE
        ItemQuantity.text! = "x" + QUANTITY
        
        if(SHIPPEDTO == SELLER_DIVISION){
            SHIPPINGTOTAL = "0.00"
            
            Total1 = Double(PRICE)! * Double(Int(QUANTITY)!)
            Total2 = Total1 + Double(SHIPPINGTOTAL)!
            
            SubTotal.text! = "MYR" + PRICE
            ShippingTotal.text! = "MYR" + SHIPPINGTOTAL
            GrandTotal.text! = "MYR" + String(format: "%.2f", Total2)
        }else{
            Total1 = Double(PRICE)! * Double(Int(QUANTITY)!)
            Total2 = Total1 + Double(SHIPPINGTOTAL)!
            
            SubTotal.text! = "MYR" + PRICE
            ShippingTotal.text! = "MYR" + SHIPPINGTOTAL
            GrandTotal.text! = "MYR" + String(format: "%.2f", Total2)
        }
        
        ButtonReceived.layer.cornerRadius = 5
        
        if(STATUS == "Ordered"){
            Ordered.textColor = .green
            Ordered_Black.isHidden = true
            Ordered_Green.isHidden = false
            
//            Pending.textColor = .green
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
//            Shipped.textColor = .green
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
//            Received.textColor = .green
            Received_Black.isHidden = false
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
            
//            Shipped.textColor = .green
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
//            Received.textColor = .green
            Received_Black.isHidden = false
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
            
//            Received.textColor = .green
            Received_Black.isHidden = false
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
            
            ButtonReceived.isHidden = true
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
            
            ButtonReceived.isHidden = true
            Finished.backgroundColor = .red
            Finished.text = "REJECT"
        }else if(STATUS == "Cancel"){
            
            Ordered_Black.isHidden = false
            Ordered_Green.isHidden = true
            
            
            Pending_Black.isHidden = false
            Pending_Green.isHidden = true
            
            
            Shipped_Black.isHidden = false
            Shipped_Green.isHidden = true
            
            
            Received_Black.isHidden = false
            Received_Green.isHidden = true
            
            ButtonReceived.isHidden = true
            Finished.backgroundColor = .red
            Finished.text = "CANCEL"
        }
        
        TrackingNo.isUserInteractionEnabled = true
        
        let TrackingClick = UITapGestureRecognizer(target: self, action: #selector(onTrackClick(sender:)))
        
        TrackingNo.addGestureRecognizer(TrackingClick)
    }
    
    func ColorFunc(){
//        let colorView1 = UIColor(hexString: "#FC4A1A").cgColor
//        let colorView2 = UIColor(hexString: "#F7B733").cgColor
//
//        let l = CAGradientLayer()
//        l.frame = self.view.bounds
//        l.colors = [colorView1, colorView2]
//        l.startPoint = CGPoint(x: 0, y: 0.5)
//        l.endPoint = CGPoint(x: 1, y: 0.5)
//        l.cornerRadius = 16
//        self.view.layer.insertSublayer(l, at: 0)
        
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonReceived.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 16
        ButtonReceived.layer.insertSublayer(ReceivedGradient, at: 0)
    }
    
    func GetPlayerData(CustomerID: String, OrderID: String){
        let parameters: Parameters=[
            "UserID": CustomerID
        ]
        
        Alamofire.request(URL_GET_PLAYERID, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let PlayerID = user.value(forKey: "PlayerID") as! [String]
                        let Name = user.value(forKey: "Name") as! [String]
                        _ = user.value(forKey: "UserID") as! [String]
                        
                        self.OneSignalNoti(PlayerID: PlayerID[0], Name: Name[0], OrderID: OrderID)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func OneSignalNoti(PlayerID: String, Name: String, OrderID: String){
        let parameters: Parameters=[
            "PlayerID": PlayerID,
            "Name": Name,
            "Words": "Order KM" + OrderID + " have been received! Please check My Selling for more details."
        ]
        
        Alamofire.request(URL_NOTI, method: .post, parameters: parameters).responseJSON
            {
                response in
            if response.result.value != nil{
                    print("ONESIGNAL SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    @objc func onTrackClick(sender: Any){
        let urlWhats = "https://www.tracking.my/poslaju/" + TRACKINGNO
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Invalid")
                }
            }
        }
    }
    
    func changeLanguage(str: String){
        OrderLable.text = "Order".localized(lang: str)
        TrackingLabel.text = "Tracking No".localized(lang: str)
        ClickLabel.text = "Click".localized(lang: str)
        ShippedLabel.text = "Shipped to".localized(lang: str)
        DateLabel.text = "Date Order".localized(lang: str)
        DateReceivedLabel.text = "Date Received".localized(lang: str)
        ButtonReceived.setTitle("Received".localized(lang: str), for: .normal)
        SubTotalLabel.text = "SubTotal".localized(lang: str)
        ShippingTotalLabel.text = "Shipping Total".localized(lang: str)
        GrandTotalLabel.text = "Grand Total".localized(lang: str)
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        default:
            break
        }
    }
}
