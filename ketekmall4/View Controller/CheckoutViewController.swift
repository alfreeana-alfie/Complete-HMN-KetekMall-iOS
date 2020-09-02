//
//  CheckoutViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class CheckoutViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return DELIVERYPRICE.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckoutCollectionViewCell", for: indexPath) as! CheckoutCollectionViewCell
            cell.OrderID.text! = self.ID[indexPath.row]
            cell.ItemName.text! = self.ADDETAIL[indexPath.row]
            cell.ItemPrice.text! = self.PRICE[indexPath.row]
            cell.Quantity.text! = self.QUANTITY[indexPath.row]
            cell.DeliveryPrice.text! = self.DELIVERYPRICE[indexPath.row]
            cell.Division.text! = self.DELIVERYDATE[indexPath.row]
            return cell
        }
    
    
    @IBOutlet weak var NamePhone: UILabel!
    @IBOutlet weak var Address: UITextView!
    @IBAction func GotoEditAddress(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "AccountSettingsViewController") as! AccountSettingsViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
    
    @IBAction func PlaceOrder(_ sender: Any) {
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
        
        //Sending http post request
        Alamofire.request(URL_CHECKOUT, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    let boostAd = self.storyboard!.instantiateViewController(identifier: "AfterPlaceOrderViewController") as! AfterPlaceOrderViewController
                    boostAd.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(boostAd, animated: true)
                    }
                }
        }
    }
    
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var CartView: UICollectionView!
    
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
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single_delivery.php"
    let URL_CART = "https://ketekmall.com/ketekmall/readcart_temp.php"
    let URL_CHECKOUT = "https://ketekmall.com/ketekmall/add_to_checkout.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartView.delegate = self
        CartView.dataSource = self
        
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                        if let result = response.result.value as? Dictionary<String,Any>{
                            if let list = result["read"] as? [Dictionary<String,Any>]{
                                for i in list{

                                    self.id = i["id"] as! String
                                    self.maincate = i["main_category"] as! String
                                    self.subcate = i["sub_category"] as! String
                                    self.addetail = i["ad_detail"] as! String
                                    self.price = i["price"] as! String
                                    self.division = i["division"] as! String
                                    self.district = i["district"] as! String
                                    self.photo = i["photo"] as! String
                                    self.sellerid = i["seller_id"] as! String
                                    self.itemid = i["item_id"] as! String
                                    self.quantity = i["quantity"] as! String
                                

                                    self.ID.append(self.id)
                                    self.MAINCATE.append(self.maincate)
                                    self.SUBCATE.append(self.subcate)
                                    
                                    self.ADDETAIL.append(self.addetail)
                                    self.PRICE.append(self.price)
                                    self.DIVISION.append(self.division)
                                    self.DISTRICT.append(self.district)
                                    self.PHOTO.append(self.photo)
                                    self.SELLERID.append(self.sellerid)
                                    self.ITEMID.append(self.itemid)
                                    self.QUANTITY.append(self.quantity)

                                    let parameters: Parameters=[
                                        "id": self.userID,
                                    ]
                                    
                                    Alamofire.request(self.URL_READ, method: .post, parameters: parameters).responseJSON
                                        {
                                            response in
                                            if let result = response.result.value as? Dictionary<String,Any>{
                                                if let list = result["read"] as? [Dictionary<String,Any>]{
                                                    for i in list{
                                                        
                                                        self.name = i["name"] as! String
                                                        self.phone_no = i["phone_no"] as! String
                                                        self.addr01 = i["address_01"] as! String
                                                        self.addr02 = i["address_02"] as! String
                                                        self.divsionu = i["division"] as! String
                                                        self.districtu = i["district"] as! String
                                                        self.postcode = i["postcode"] as! String
                                                        
                                                        self.NAME.append(self.name)
                                                        self.PHONE_NO.append(self.phone_no)
                                                        self.ADDR01.append(self.addr01)
                                                        self.ADDR02.append(self.addr02)
                                                        self.DIVISIONU.append(self.divsionu)
                                                        self.DISTRICTU.append(self.districtu)
                                                        self.POSTCODE.append(self.postcode)
                                                        
                                                        self.NamePhone.text! = self.name + " | " + self.phone_no
                                                        
                                                        self.NEWADDR =  self.addr01 + " " + self.addr02 + "\n" + self.divsionu + " " + self.postcode
                                                        self.Address.text! = self.NEWADDR
                                            
                                                        let parameters: Parameters=[
                                                            "item_id": self.itemid,
                                                            "division": self.divsionu
                                                        ]
                                                        
                                                        Alamofire.request(self.URL_READ_DELIVERY, method: .post, parameters: parameters).responseJSON
                                                            {
                                                                response in
                                                                if let result = response.result.value as? Dictionary<String,Any>{
                                                                    if let list = result["read"] as? [Dictionary<String,Any>]{
                                                                        for i in list{

                                                                            self.DeliveryID = i["id"] as! String
                                                                            self.DeliveryDivision = i["division"] as! String
                                                                            self.DeliveryDistrict = i["district"] as! String
                                                                            self.DeliveryDays = i["days"] as! String
                                                                            self.DeliveryPrice = i["price"] as! String

                                                                            self.DELIVERYID.append(self.DeliveryID)
                                                                            self.DELIVERYPRICE.append(self.DeliveryPrice)
                                                                            self.DELIVERYDAYS.append(self.DeliveryDays)
                                                                            self.DELIVERYDIVISION.append(self.DeliveryDivision)
                                                                            self.DELIVERYDISTRICT.append(self.DeliveryDistrict)
                                                                            
                                                                            let date = Date()
                                                                            let components = Calendar.current.dateComponents([.month, .day, .year], from: date)

                                                                            let now = DateComponents(calendar: Calendar.current, timeZone: TimeZone(abbreviation: "GMT"), year: components.year, month: components.month, day: components.day)
                                                                            let duration = DateComponents(calendar: Calendar.current, day: Int(self.DeliveryDays))
                                                                            let later = Calendar.current.date(byAdding: duration, to: now.date!)
                                                                            
                                                                            let formatter = DateFormatter()
                                                                            formatter.locale = Locale(identifier: "nl_NL")
                                                                            formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")

                                                                            let datetime = formatter.string(from: later!)
                                                                            print(datetime)
                                                                            self.DELIVERYDATE.append(datetime)
                                                                            print(self.DELIVERYPRICE)
                                                                            
                                                                            self.CartView.reloadData()
                                                                        }

                                                                    }else{
                                                                        print("FAILED")
                                                                    }

                                                                }else{
                                                                    print("FAILED")
                                                                }
                                                        }
                                                    }

                                                }else{
                                                    print("FAILED")
                                                }

                                            }else{
                                                print("FAILED")
                                            }
                                    }
                                }

                            }else{
                                print("FAILED")
                            }

                        }
                        
                    
                
        }
    }
    
}
