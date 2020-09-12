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
import JGProgressHUD

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartDelegate, UITabBarDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
    
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
    var PRICENEW: [String] = []
    var QUANTITYNEW: [String] = []
    var Quan: String = ""
    var userID: String = ""
    var sub: Double = 0.00
    var SubTotal: Double = 0.00
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    @IBOutlet weak var CartView: UICollectionView!
    @IBOutlet weak var GrandTotal: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var ButtonCheckout: UIButton!
    @IBOutlet weak var Tabbar: UITabBar!
    
    var viewController1: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Tabbar.delegate = self
        
        CartView.delegate = self
        CartView.dataSource = self
        
        ButtonCheckout.layer.cornerRadius = 5
        
        ViewList()
    }
    
    func changeLanguage(str: String){
        ButtonCheckout.titleLabel?.text = "Checkout".localized(lang: str)
        Total.text = "Total".localized(lang: str)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            presentMethod(storyBoardName: "Main", storyBoardID: "HomeViewController")
            break
            
        case 2:
            presentMethod(storyBoardName: "Main", storyBoardID: "NotificationViewController")
            break
            
        case 3:
            presentMethod(storyBoardName: "Main", storyBoardID: "ViewController")
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

    
    func ViewList(){
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        Alamofire.request(URL_READ_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
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
    
    func onDeleteClick(cell: CartCollectionViewCell) {
        guard let indexPath = self.CartView.indexPath(for: cell) else{
            return
        }
        let parameters: Parameters=[
            "id": self.ID[indexPath.row],
            "cart_id": self.ID[indexPath.row],
            
        ]
        Alamofire.request(URL_DELETE_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
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
        cell.CheckBOx.layer.cornerRadius = 5
        cell.SubTotal.text! = self.PRICE[indexPath.row]
        
        cell.CheckBOx.valueChanged = { (isChecked) in
            if(isChecked == false){
                let parameters: Parameters=[
                    "cart_id": self.ID[indexPath.row],
                ]
                Alamofire.request(self.URL_DELETE_CART_TEMP, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                            
                            var SubTotal1: Double = 0.00
                            SubTotal1 = Double(self.PRICE[indexPath.row])! * Double(Int(cell.Quantity.text!)!)
                            if let index = self.PRICENEW.firstIndex(of: String(format: "%.2f", SubTotal1)) {
                                self.PRICENEW.remove(at: index)
                                if(self.PRICENEW.count == 0){
                                    self.GrandTotal.text! = "MYR0.00"
                                }
                                var SubTotal2 = 0.00
                                for i in self.PRICENEW{
                                    SubTotal2 += Double(i)!
                                    self.GrandTotal.text! = "MYR" + String(format: "%.2f", SubTotal2)
                                    
                                }
                            }
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
                var SubTotal1: Double = 0.00
                SubTotal1 = Double(self.PRICE[indexPath.row])! * Double(Int(cell.Quantity.text!)!)
                self.PRICENEW.append(String(format: "%.2f", SubTotal1))
            
                Alamofire.request(self.URL_ADD_CART_TEMP, method: .post, parameters: parameters).responseJSON
                    {
                        response in
//                        if let result = response.result.value {
//                            let jsonData = result as! NSDictionary
                            var SubTotal2 = 0.00
                            for i in self.PRICENEW{
                                SubTotal2 += Double(i)!
                                self.GrandTotal.text! = "MYR" + String(format: "%.2f", SubTotal2)
                            }
//                        }
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
        cell.Stepper.transform = CGAffineTransform(scaleX: 1.75, y: 1.0);
        cell.Stepper.layer.cornerRadius = 5
        return cell
    }
    
    func OnAddClick(cell: CartCollectionViewCell) {}
    
    
    @IBAction func Checkout(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
}
