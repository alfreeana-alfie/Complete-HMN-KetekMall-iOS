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

class CheckoutViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITabBarDelegate, UICollectionViewDelegateFlowLayout, CheckoutDelegate {
    func onSelfClick(cell: CheckoutCollectionViewCell) {
        guard let indexPath = self.CartView.indexPath(for: cell) else{
            return
        }
        
        var newPrice: Double = 0.00
        var newGrandTotal: Double = 0.00
        
        
        newGrandTotal = Double(self.GRANDTOTAL[indexPath.row])! - Double(self.DELIVERYPRICE[indexPath.row])!
        newPrice = Double(self.DELIVERYPRICE[indexPath.row])! - Double(self.DELIVERYPRICE[indexPath.row])!
        
        print(String(format: "%.2f", newGrandTotal))
        self.GrandTotal.text! = "MYR" + String(format: "%.2f", newGrandTotal)
        self.GrandTotal2.text! = String(format: "%.2f", newGrandTotal)
        
        cell.DeliveryPrice.text! = "MYR" + String(format: "%.2f", newPrice)
        
        cell.ButtonSelfPickUp.isHidden = true
    }
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var NamePhone: UILabel!
    @IBOutlet weak var Address: UITextView!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var GrandTotal2: UILabel!
    @IBOutlet weak var CartView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var ButtonPlaceOrder: UIButton!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var DeliveryAddressLabel: UILabel!
    @IBOutlet weak var ChangeDeliveryLabel: UILabel!
    @IBOutlet weak var GrandTotalView: UIView!
    
    var viewController1: UIViewController?
    
    //Delivery Part
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
    var EMAIL: [String] = []
    var ADDR01: [String] = []
    var ADDR02: [String] = []
    var DIVISIONU: [String] = []
    //    var DISTRICTU: [String] = []
    var POSTCODE: [String] = []
    var GRANDTOTAL: [String] = []
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single_delivery.php"
    let URL_READ_DELIVERY2 = "https://ketekmall.com/ketekmall/read_detail_delivery_single.php"
    let URL_CART = "https://ketekmall.com/ketekmall/readcart_temp.php"
    let URL_CHECKOUT = "https://ketekmall.com/ketekmall/add_to_checkout.php"
    let URL_SEND_EMAILBUYER = "https://ketekmall.com/ketekmall/sendEmail_buyer.php"
    let URL_SEND_EMAILSELLER = "https://ketekmall.com/ketekmall/sendEmail_seller.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_cart_temp_user.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewWillDisappear(_ animated: Bool) {
        DeleteOrder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        //        userID = sharedPref.string(forKey: "USERID") ?? "0"
        
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        Tabbar.delegate = self
        CartView.delegate = self
        CartView.dataSource = self
        
        GrandTotal2.isHidden = true
        ChangeDeliveryLabel.isHidden = true
        ButtonPlaceOrder.layer.cornerRadius = 7
        
        spinner.show(in: self.view)
        
        ReadCart()
        
    }
    
    func ReadCart(){
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        Alamofire.request(URL_CART, method: .post, parameters: parameters).responseJSON
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
                                        self.EMAIL = user.value(forKey: "email") as! [String]
                                        self.ADDR01 = user.value(forKey: "address_01") as! [String]
                                        self.ADDR02 = user.value(forKey: "address_02") as! [String]
                                        self.DIVISIONU = user.value(forKey: "division") as! [String]
                                        self.POSTCODE = user.value(forKey: "postcode") as! [String]
                                        
                                        self.divsionu = self.DIVISIONU[0]
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
                                                            
                                                            if(user.count == 0){
                                                                self.DELIVERYID = [""]
                                                                self.DELIVERYDIVISION = [""]
                                                                let deliveryDays = ["Not Supported for selected area"]
                                                                let deliveryprice = ["Not Supported for selected area"]
                                                                
                                                                self.DELIVERYPRICE.append(contentsOf: deliveryprice)
                                                                self.DELIVERYDAYS.append(contentsOf: deliveryDays)
                                                                
                                                                self.ButtonPlaceOrder.isHidden = true
                                                                self.TotalLabel.isHidden = true
                                                                self.GrandTotal.isHidden = true
                                                                self.ChangeDeliveryLabel.isHidden = false
                                                                //                                                                self.GrandTotal.text! = "MYR0.00"
                                                                self.CartView.reloadData()
                                                            }else
                                                            {
                                                                self.DELIVERYID = user.value(forKey: "id") as! [String]
                                                                self.DELIVERYDIVISION = user.value(forKey: "division") as! [String]
                                                                let deliveryDays = user.value(forKey: "days") as! [String]
                                                                let deliveryprice = user.value(forKey: "price") as! [String]
                                                                
                                                                self.DELIVERYPRICE.append(contentsOf: deliveryprice)
                                                                self.DELIVERYDAYS.append(contentsOf: deliveryDays)
                                                                
                                                                var index = i
                                                                
                                                                if index < self.DELIVERYPRICE.count{
                                                                    //                                                                    print("SUCCESS" + self.DELIVERYPRICE[index])
                                                                    var strDays: Int = Int(self.DELIVERYDAYS[index]) ?? 0
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
                                                                    var strDel: Double = Double(self.DELIVERYPRICE[i]) ?? 0.00
                                                                    var strGrandTotal: Double = 0.00
                                                                    strGrand2 += strDel
                                                                    strGrandTotal = strGrand + strGrand2
                                                                    //                                                                    print(String(format: "%.2f", strGrandTotal))
                                                                    
                                                                    self.GrandTotal.text! = "MYR" + String(format: "%.2f", strGrandTotal)
                                                                    
                                                                    self.GrandTotal2.text! = String(format: "%.2f", strGrandTotal)
                                                                    
                                                                    self.GRANDTOTAL.append(String(format: "%.2f", strGrandTotal))
                                                                }
                                                                self.CartView.reloadData()
                                                                
                                                            }
                                                        }else{
                                                            print("Invalid")
                                                        }
                                                    }
                                            }
                                        }
                                    }else{
                                        print("Invalid")
                                    }
                                }
                        }
                    }
                }
        }
    }
    
    func AddCheckout(){
        spinner.show(in: self.view)
        for i in 0..<self.SELLERID.count{
            let parameters: Parameters=[
                "seller_id": self.SELLERID[i],
                "customer_id": userID,
                "ad_detail": self.ADDETAIL[i],
                "main_category":self.MAINCATE[i],
                "sub_category": self.SUBCATE[i],
                "price": self.PRICE[i],
                "division": self.divsionu,
                "district": self.divsionu,
                "seller_division": self.DIVISION[i],
                "seller_district": self.DISTRICT[i],
                "photo": self.PHOTO[i],
                "item_id": self.ITEMID[i],
                "quantity": self.QUANTITY[i],
                "delivery_price": self.DELIVERYPRICE[i],
                "delivery_date": self.DELIVERYDATE[i],
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
                    }
            }
        }
    }
    
    func changeLanguage(str: String){
        TotalLabel.text = "Total".localized(lang: str)
        DeliveryAddressLabel.text = "Delivery Address".localized(lang: str)
        ButtonPlaceOrder.setTitle("Place Order".localized(lang: str), for: .normal)
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            DeleteOrder()
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            DeleteOrder()
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            DeleteOrder()
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
    
    func DeleteOrder(){
        let parameters: Parameters=[
            "customer_id": userID,
            
        ]
        Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED")
                }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DELIVERYPRICE.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 230);
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
        cell.delegate = self
        
        cell.ButtonSelfPickUp.layer.cornerRadius = 7
        cell.ButtonSelfPickUp.isHidden = true
        cell.ButtonSelfPickUp.layer.borderWidth = 1
        cell.ButtonSelfPickUp.layer.borderColor = CGColor(srgbRed: 1.000, green: 0.765, blue: 0.000, alpha: 1.000)
        
        if(self.DIVISIONU[0] == DIVISION[indexPath.row]){
            cell.ButtonSelfPickUp.isHidden = false
        }else{
            cell.ButtonSelfPickUp.isHidden = true
        }
        
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.OrderID.text! = "KM" + self.ID[indexPath.row]
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        
        cell.ItemPrice.text! = "MYR" + self.PRICE[indexPath.row]
        cell.Quantity.text! = "x" + self.QUANTITY[indexPath.row]
        cell.DeliveryPrice.text! = "MYR" + self.DELIVERYPRICE[indexPath.row]
        if(self.DELIVERYPRICE[indexPath.row] == "Not Supported for selected area"){
            cell.DeliveryPrice.text! = self.DELIVERYPRICE[indexPath.row]
        }else{
            cell.DeliveryPrice.text! = "MYR" + self.DELIVERYPRICE[indexPath.row]
        }
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
        
        AddCheckout()
        let myBuying = self.storyboard!.instantiateViewController(identifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
        myBuying.userID = self.userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
        
        let vc = DetailViewController()
        vc.UserName = self.NAME[0]
        vc.UserEmail = self.EMAIL[0]
        vc.UserContact = self.PHONE_NO[0]
        vc.Amount = self.GrandTotal2.text!


        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getSellerDetails(){
        for i in 0..<self.SELLERID.count{
            let parameters: Parameters=[
                "id": SELLERID[i],
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
        
    }
    
    func sendEmail(Email: String){
        let parameters: Parameters=[
            "email": Email
        ]
        
        Alamofire.request(URL_SEND_EMAILSELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    print("SENT")
                }else{
                    print("FAILED")
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
            "email": Email
        ]
        Alamofire.request(URL_SEND_EMAILBUYER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    print("SENT")
                }else{
                    print("FAILED")
                }
        }
    }
    
}
