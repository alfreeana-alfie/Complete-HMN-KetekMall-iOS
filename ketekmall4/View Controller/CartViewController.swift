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

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CartDelegate, UITabBarDelegate, UICollectionViewDelegateFlowLayout {
    func OnAddClick(cell: CartCollectionViewCell) {
        //TODO
    }
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    
    let URL_READ_CART = "https://ketekmall.com/ketekmall/readcart.php"
    let URL_DELETE_CART = "https://ketekmall.com/ketekmall/delete_cart2.php"
    let URL_ADD_CART_TEMP = "https://ketekmall.com/ketekmall/add_to_cart_temp.php"
    let URL_READ_CART_TEMP = "https://ketekmall.com/ketekmall/readcart_temp.php"
    let URL_DELETE_CART_TEMP = "https://ketekmall.com/ketekmall/delete_cart_temp.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_cart_temp_user.php"
    
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
    var WEIGHT: [String] = []
    var POSTCODE: [String] = []
    
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        userID = sharedPref.string(forKey: "USERID") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        Tabbar.delegate = self
        
        CartView.delegate = self
        CartView.dataSource = self
        
        ButtonCheckout.layer.cornerRadius = 5
        ButtonCheckout.isHidden = true
        
        ViewList()
    }
    
    func ColorFunc(){
        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ViewGradient = CAGradientLayer()
        ViewGradient.frame = self.view.bounds
        ViewGradient.colors = [colorViewOne, colorViewTwo]
        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ViewGradient.cornerRadius = 16
        self.view.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorCheckOutOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorCheckOutTwo = UIColor(hexString: "#F7B733").cgColor
        
        let CheckOutGradient = CAGradientLayer()
        CheckOutGradient.frame = ButtonCheckout.bounds
        CheckOutGradient.colors = [colorCheckOutOne, colorCheckOutTwo]
        CheckOutGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CheckOutGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CheckOutGradient.cornerRadius = 7
        ButtonCheckout.layer.insertSublayer(CheckOutGradient, at: 0)
      
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        DeleteOrder()
    }
    
    func changeLanguage(str: String){
        ButtonCheckout.setTitle("Checkout".localized(lang: str), for: .normal)
        Total.text = "Total".localized(lang: str)
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
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
                        let postcode = user.value(forKey: "postcode") as? [String] ?? ["93050"]
                        let weight = user.value(forKey: "weight") as? [String] ?? ["1.00"]
                        
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
                        self.POSTCODE = postcode
                        self.WEIGHT = weight
                        
                        self.CartView.reloadData()
                    }
                }
        }
    }
    
    func onDeleteClick(cell: CartCollectionViewCell) {
        let refreshAlert = UIAlertController(title: "Remove", message: "Are you sure?", preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            guard let indexPath = self.CartView.indexPath(for: cell) else{
                return
            }
            let parameters: Parameters=[
                "id": self.ID[indexPath.row]
                
            ]
            Alamofire.request(self.URL_DELETE_CART, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print(jsonData.value(forKey: "message")!)
                        self.ID.remove(at: indexPath.row)
                        self.PHOTO.remove(at: indexPath.row)
                        self.ADDETAIL.remove(at: indexPath.row)
                        self.PRICE.remove(at: indexPath.row)
                        self.CartView.deleteItems(at: [indexPath])
                    }
            }
            return
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            return
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 160);
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CartCollectionViewCell", for: indexPath) as! CartCollectionViewCell
        let NEWIm = self.PHOTO[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.AdDetail.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.PRICE[indexPath.row]
        
        cell.Quantity.isHidden = true
//        cell.Stepper.isHidden = true
        cell.CheckBOx.checkmarkStyle = .tick
        cell.CheckBOx.borderStyle = .circle
        cell.CheckBOx.layer.cornerRadius = 5
        cell.SubTotal.text! = "MYR" + self.PRICE[indexPath.row]
        
        
        if(lang == "ms"){
            cell.SubLabel.text = "SubTotal".localized(lang: "ms")
            cell.QuantityLabel.text = "Quantity".localized(lang: "ms")
        }else{
            cell.SubLabel.text = "SubTotal".localized(lang: "en")
            cell.QuantityLabel.text = "Quantity".localized(lang: "en")
        }
        
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
                                    self.ButtonCheckout.isHidden = true
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
                self.ButtonCheckout.isHidden = false
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
                    "quantity": cell.StepperNew.value,
                    "cart_id": self.ID[indexPath.row],
                    "postcode": self.POSTCODE[indexPath.row],
                    "weight": self.WEIGHT[indexPaht.row]
                ]
                var SubTotal1: Double = 0.00
                SubTotal1 = Double(self.PRICE[indexPath.row])! * Double(Int(cell.Quantity.text!)!)
                self.PRICENEW.append(String(format: "%.2f", SubTotal1))
            
                Alamofire.request(self.URL_ADD_CART_TEMP, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                            var SubTotal2 = 0.00
                            for i in self.PRICENEW{
                                SubTotal2 += Double(i)!
                                self.GrandTotal.text! = "MYR" + String(format: "%.2f", SubTotal2)
                            }
                }
            }
            
        }
        
        cell.delegate = self
        cell.callback = { stepper in
            self.Quan = stepper
            
            var sub: Double = 0.00
            sub = Double(self.PRICE[indexPath.row])! * Double(stepper)!
            cell.SubTotal.text! = "MYR" + String(sub)
        }
        return cell
    }
    
    func OnAddClick2(cell: CartCollectionViewCell) {}
    
    
    @IBAction func Checkout(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
}
