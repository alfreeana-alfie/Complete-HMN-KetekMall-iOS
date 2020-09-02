//
//  CartViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import SimpleCheckbox

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartDelegate {
    func onDeleteClick(cell: CartCollectionViewCell) {
        guard let indexPath = self.CartView.indexPath(for: cell) else{
            return
        }
        let parameters: Parameters=[
            "id": self.ID[indexPath.row],
            "cart_id": self.ID[indexPath.row],
            
        ]
        
        //Sending http post request
        Alamofire.request(URL_DELETE_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
//                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.AdDetail.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = self.PRICE[indexPath.row]
        
        cell.CheckBOx.checkmarkStyle = .tick
        cell.CheckBOx.borderStyle = .circle
        cell.SubTotal.text! = self.PRICE[indexPath.row]
        
        cell.CheckBOx.valueChanged = { (isChecked) in
            if(isChecked == false){
                let parameters: Parameters=[
                    "cart_id": self.ID[indexPath.row],
                ]
                Alamofire.request(self.URL_DELETE_CART_TEMP, method: .post, parameters: parameters).responseJSON
                    {
                        response in
//                        print(response)
                        
                        //getting the json value from the server
                        if let result = response.result.value {
                            
                            //converting it as NSDictionary
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
//                            self.SUB.remove(at: in)
//                            print("%.2f" , self.SUB)
//                            for pair in self.SUB.enumerated() {
//                                self.sub -= pair.element//listPrice[pair.index]
//                            }
//                            self.GrandTotal.text! = String(format: "%.2f" , self.sub)
                        }
                }
            }else{
                let parameters: Parameters=[
                    "customer_id": self.userID,
                    "main_category": self.MAINCATE[indexPath.row],
                    "sub_category": self.SUBCATE[indexPath.row],
                    "ad_detail": self.ADDETAIL[indexPath.row],
                    "price": self.PRICE[indexPath.row],
                    "division": self.DIVISION[indexPath.row],
                    "district": self.DISTRICT[indexPath.row],
                    "photo": self.PHOTO[indexPath.row],
                    "seller_id": self.SELLERID[indexPath.row],
                    "item_id": self.ITEMID[indexPath.row],
                    "quantity": cell.Quantity.text!,
                    "cart_id": self.ID[indexPath.row],
                    
                ]
                
                //Sending http post request
                Alamofire.request(self.URL_ADD_CART_TEMP, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        //printing response
//                        print(response)
                        
                        //getting the json value from the server
                        if let result = response.result.value {
                            
                            //converting it as NSDictionary
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)

//                            self.SUB.append(Double(self.PRICE[indexPath.row])! * Double(cell.Quantity.text!)!)
//                            print("%.2f" , self.SUB)
//                            
//                            for pair in self.SUB.enumerated() {
//                                self.sub += pair.element//listPrice[pair.index]
//                            }
//                            self.GrandTotal.text! = String(format: "%.2f" , self.sub)
                        }
                }
            }
            
        }
        
        cell.delegate = self
        
        cell.callback = { stepper in
            self.Quan = stepper
            
            var sub: Double = 0.00
            sub = Double(self.PRICE[indexPath.row])! * Double(stepper)!
            cell.SubTotal.text! = String(sub)
        }
        return cell
    }
    
    func OnAddClick(cell: CartCollectionViewCell) {}
    
    @IBOutlet weak var GrandTotal: UILabel!
    @IBAction func Checkout(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
    
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart.php"
    let URL_DELETE_CART = "https://ketekmall.com/ketekmall/delete_cart.php"
    let URL_ADD_CART_TEMP = "https://ketekmall.com/ketekmall/add_to_cart_temp.php"
    let URL_READ_CART_TEMP = "https://ketekmall.com/ketekmall/readcart_temp.php"
    let URL_DELETE_CART_TEMP = "https://ketekmall.com/ketekmall/delete_cart_temp.php"

    var ID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var DIVISION: [String] = []
    var DISTRICT: [String] = []
    var PHOTO: [String] = []
    var SELLERID: [String] = []
    var ITEMID: [String] = []
    var QUANTITY: [String] = []
    var SUB: [Double] = []
    var Quan: String = ""
    var userID: String = ""
    var sub: Double = 0.00
    
    @IBOutlet weak var CartView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CartView.delegate = self
        CartView.dataSource = self
        
        let parameters: Parameters=[
                    "customer_id": userID,
                ]
                
                //Sending http post request
                Alamofire.request(URL_READ_CART, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value{
                            let jsonData = result as! NSDictionary
                            
                            if((jsonData.value(forKey: "success") as! NSString).boolValue){
                                let user = jsonData.value(forKey: "read") as! NSArray
                                
                                let ID = user.value(forKey: "id") as! [String]
                                let maincate = user.value(forKey: "main_category") as! [String]
                                let subcate = user.value(forKey: "sub_category") as! [String]
                                let AdDetail = user.value(forKey: "ad_detail") as! [String]
                                let Price = user.value(forKey: "price") as! [String]
                                let division = user.value(forKey: "division") as! [String]
                                let district = user.value(forKey: "district") as! [String]
                                let Photo = user.value(forKey: "photo") as! [String]
                                let seller_id = user.value(forKey: "seller_id") as! [String]
                                let item_id = user.value(forKey: "item_id") as! [String]
                                
                                
                                self.ID = ID
                                self.MAINCATE = maincate
                                self.SUBCATE = subcate
                                self.ADDETAIL = AdDetail
                                self.PRICE = Price
                                self.DIVISION = division
                                self.DISTRICT = district
                                self.PHOTO = Photo
                                self.SELLERID = seller_id
                                self.ITEMID = item_id

                                self.CartView.reloadData()
                                
                            }
                        }
                }
    }
}
