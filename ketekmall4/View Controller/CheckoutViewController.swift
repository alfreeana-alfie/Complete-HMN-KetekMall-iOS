//
//  CheckoutViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class CheckoutViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate, UICollectionViewDelegateFlowLayout {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var NamePhone: UILabel!
    @IBOutlet weak var Address: UITextView!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var CartView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    var added = Set<String>()
    
    var viewController1: UIViewController?
    var userID: String = ""
    var NEWADDR: String = ""
    var DeliveryID: String = ""
    var DeliveryDivision: String = ""
    var DeliveryDistrict: String = ""
    var DeliveryDays: String = ""
    var DeliveryPrice: String = ""
    
    var id: String = ""
    var addetail: String = ""
    var price: String = ""
    var maincate: String = ""
    var subcate: String = ""
    var division: String = ""
    var district: String = ""
    
    var photo: String = ""
    var sellerid: String = ""
    var itemid: String = ""
    var quantity: String = ""
    var name: String = ""
    var phone_no: String = ""
    var addr01: String = ""
    var addr02: String = ""
    var divsionu: String = ""
    var districtu: String = ""
    var postcode: String = ""
    
    var ID: [String] = []
    var ITEMID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var DIVISION: [String] = []
    var DISTRICT: [String] = []
    var PHOTO: [String] = []
    var SELLERID: [String] = []
    var QUANTITY: [String] = []
    
    var DELIVERYDIVISION: [String] = []
    var DELIVERYDISTRICT: [String] = []
    var DELIVERYPRICE: [String] = []
    var DELIVERYDAYS: [String] = []
    var DELIVERYDATE: [String] = []
    var DELIVERYID: [String] = []
    
    var NAME: [String] = []
    var PHONE_NO: [String] = []
    var ADDR01: [String] = []
    var ADDR02: [String] = []
    var DIVISIONU: [String] = []
    var DISTRICTU: [String] = []
    var POSTCODE: [String] = []
    
    var GRANDTOTAL: [String] = []
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single_delivery.php"
    let URL_READ_DELIVERY2 = "https://ketekmall.com/ketekmall/read_detail_delivery_single.php"
    let URL_CART = "https://ketekmall.com/ketekmall/readcart_temp.php"
    let URL_CHECKOUT = "https://ketekmall.com/ketekmall/add_to_checkout.php"
    let URL_SEND_EMAILBUYER = "https://ketekmall.com/ketekmall/sendEmail_buyer.php"
    let URL_SEND_EMAILSELLER = "https://ketekmall.com/ketekmall/sendEmail_seller.php"
    
    let sharedPref = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID = sharedPref.string(forKey: "USERID") ?? "0"
        
        print("userid" + userID)
        Tabbar.delegate = self
        
        CartView.delegate = self
        CartView.dataSource = self
        
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        Alamofire.request(self.URL_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                var strGrand: Double = 0.00
                var strGrand2: Double = 0.00
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        
                        let user = jsonData.value(forKey: "read") as! NSArray

                        self.ID = user.value(forKey: "id") as! [String]
                        self.MAINCATE = user.value(forKey: "main_category") as! [String]
                        self.SUBCATE = user.value(forKey: "sub_category") as! [String]
                        self.ADDETAIL = user.value(forKey: "ad_detail") as! [String]
                        self.PRICE = user.value(forKey: "price") as! [String]
                        self.DIVISION = user.value(forKey: "division") as! [String]
                        self.DISTRICT = user.value(forKey: "district") as! [String]
                        self.ITEMID = user.value(forKey: "item_id") as! [String]
                        self.QUANTITY = user.value(forKey: "quantity") as! [String]
                        self.PHOTO = user.value(forKey: "photo") as! [String]
                        self.SELLERID = user.value(forKey: "seller_id") as! [String]
                        
                        let parameters: Parameters=[
                            "id": self.userID,
                        ]
                        Alamofire.request(self.URL_READ, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                
                                
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    
                                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                        
                                        let user = jsonData.value(forKey: "read") as! NSArray
                                        self.NAME = user.value(forKey: "name") as! [String]
                                        self.PHONE_NO = user.value(forKey: "phone_no") as! [String]
                                        self.ADDR01 = user.value(forKey: "address_01") as! [String]
                                        self.ADDR02 = user.value(forKey: "address_02") as! [String]
                                        self.DIVISIONU = user.value(forKey: "division") as! [String]
                                        self.POSTCODE = user.value(forKey: "postcode") as! [String]

                                        self.NamePhone.text! = self.NAME[0] + " | " + self.PHONE_NO[0]
                                        self.NEWADDR =  self.ADDR01[0] + " " + self.ADDR02[0] + "\n" + self.DIVISIONU[0] + " " + self.POSTCODE[0]
                                        
                                        self.Address.text! = self.NEWADDR
                                        
                                        for i in 0..<self.ITEMID.count{
                                            
                                            let parameters: Parameters=[
                                                "item_id": self.ITEMID[i],
                                                "division": self.DIVISIONU[0]
                                            ]
                                            
                                            Alamofire.request(self.URL_READ_DELIVERY, method: .post, parameters: parameters).responseJSON
                                                {
                                                    response in
                                                    self.spinner.dismiss(afterDelay: 3.0)
                                                    
                                                    if let result = response.result.value{
                                                        let jsonData = result as! NSDictionary
                                                        
                                                        if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                                            let user = jsonData.value(forKey: "read") as! NSArray
                                                            
                                                            self.DELIVERYID = user.value(forKey: "id") as! [String]
                                                            self.DELIVERYDIVISION = user.value(forKey: "division") as! [String]
                                                            let deliveryDays = user.value(forKey: "id") as! [String]
                                                            self.DELIVERYID = user.value(forKey: "id") as! [String]
                                                            let deliveryprice = user.value(forKey: "price") as! [String]
                                                            
                                                            self.DELIVERYPRICE.append(contentsOf: deliveryprice)
                                                            self.DELIVERYDAYS.append(contentsOf: deliveryDays)
                                                            
                                                            
                                                            var index = i
                                                            
                                                            if index < self.DELIVERYPRICE.count{
                                                                print("SUCCESS" + self.DELIVERYPRICE[index])
                                                                var strDays: Int = Int(self.DELIVERYDAYS[index])!
                                                                let date = Date()
                                                                let components = Calendar.current.dateComponents([.month, .day, .year], from: date)
                                                                
                                                                let now = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "GMT"), year: components.year, month: components.month, day: components.day)
                                                                let duration = DateComponents(calendar: Calendar.current, day: strDays)
                                                                let later = Calendar.current.date(byAdding: duration, to: now.date!)
                                                                
                                                                let formatter = DateFormatter()
                                                                formatter.locale = Locale(identifier: "nl_NL")
                                                                formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
                                                                
                                                                let datetime = formatter.string(from: later!)
                                                                
                                                                index += 1
                                                                
                                                                self.DELIVERYDATE.append(datetime)
                                                            }else{
                                                                print("FAILED")
                                                            }
                                                            
                                                            
                                                            strGrand += (Double(self.PRICE[i])! * Double(Int(self.QUANTITY[i])!))
                                                            
                                                            var indexPrice = i
                                                            
                                                            if indexPrice < self.DELIVERYPRICE.count{
                                                                var strDel: Double = Double(self.DELIVERYPRICE[i])!
                                                                var strGrandTotal: Double = 0.00
                                                                strGrand2 += strDel
                                                                strGrandTotal = strGrand + strGrand2
                                                                print(String(format: "%.2f", strGrandTotal))
                                                                
                                                                self.GrandTotal.text! = "MYR" + String(format: "%.2f", strGrandTotal)
                                                            }
                                                           
                                                            
                                                            self.CartView.reloadData()
                                                        }else{
                                                            
                                                            print("Invalid email or password")
                                                        }
                                                    }
                                            }
                                        }
                                    }else{
                                        
                                        print("Invalid email or password")
                                    }
                                }
                        }
                    }
                }
        }
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
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DELIVERYPRICE.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 214);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCollectionViewCell", for: indexPath) as! CheckoutCollectionViewCell
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.OrderID.text! = self.ID[indexPath.row]
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = self.PRICE[indexPath.row]
        cell.Quantity.text! = self.QUANTITY[indexPath.row]
        cell.DeliveryPrice.text! = self.DELIVERYPRICE[indexPath.row]
        cell.Division.text! = self.DIVISION[indexPath.row] + " to " + self.DIVISIONU[0]
        return cell
    }
    
    
    
    @IBAction func GotoEditAddress(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "AccountSettingsViewController") as! AccountSettingsViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
    
    @IBAction func PlaceOrder(_ sender: Any) {
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": self.SELLERID,
            "customer_id": userID,
            "ad_detail": self.ADDETAIL,
            "main_category":self.MAINCATE,
            "sub_category":self.SUBCATE,
            "price": self.PRICE,
            "division": self.DIVISIONU,
            "district": self.DISTRICTU,
            "seller_division": self.DIVISION,
            "seller_district": self.DISTRICT,
            "photo": self.PHOTO,
            "item_id": self.ITEMID,
            "quantity": self.QUANTITY,
            "delivery_price": self.DELIVERYPRICE,
            "delivery_date": self.DELIVERYDATE,
            "delivery_addr": self.NEWADDR
        ]
        Alamofire.request(URL_CHECKOUT, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    self.getSellerDetails()
                    self.getUserDetails()
                    
                    let boostAd = self.storyboard!.instantiateViewController(identifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
                    boostAd.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(boostAd, animated: true)
                    }
                }
        }
    }
    
    func getSellerDetails(){
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
                        self.sendEmail(Email: SellerEmail[0])
                    }
                }
        }
    }
    
    func sendEmail(Email: String){
        let parameters: Parameters=[
            "email": Email,
        ]

        Alamofire.request(URL_SEND_EMAILSELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SENT")
                    }
                }
        }
    }
    
    func getUserDetails(){
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
                        let email = user.value(forKey: "email") as! [String]
                        
                        self.sendEmailBuyer(Email: email[0])
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func sendEmailBuyer(Email: String){
        let parameters: Parameters=[
            "email": Email,
        ]
        Alamofire.request(URL_SEND_EMAILBUYER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SENT")
                        
                    }
                }
        }
    }
    
}
