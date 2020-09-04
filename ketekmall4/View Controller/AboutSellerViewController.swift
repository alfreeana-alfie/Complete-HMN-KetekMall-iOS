//
//  AboutSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class AboutSellerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, AboutSellerDelegate {
    
    let URL_READ_SELLER = "https://ketekmall.com/ketekmall/read_order_done_seller_shop.php"
    let URL_READALL_SELLER = "https://ketekmall.com/ketekmall/readall_seller.php"
    let URL_ADD_FAV = "https://ketekmall.com/ketekmall/add_to_fav.php"
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    

    @IBOutlet weak var AboutSellerView: UICollectionView!
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerLocation: UILabel!
    @IBOutlet weak var Products: UILabel!
    @IBOutlet weak var Sold: UILabel!

    var UserID: String = ""
    var SELLERID1: String = ""
    var SELLLERNAME: String = ""
    var SELLERLOCATION: String = ""
    var SELLERIMAGE: String = ""
    var SELLERPHONE: String = ""
    
    var SELLERID: [String] = []
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var BRAND: [String] = []
    var INNER: [String] = []
    var STOCK: [String] = []
    var DESC: [String] = []
    var MAXORDER: [String] = []
    var DIVISION: [String] = []
    var RATING: [String] = []
    var ITEMID: [String] = []
    var ADDETAIL: [String] = []
    var PRICE: [String] = []
    var PHOTO: [String] = []
    var DISTRICT: [String] = []
    var SOLD: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AboutSellerView.delegate = self
        AboutSellerView.dataSource = self
        
        SellerName.text! = SELLLERNAME
        SellerLocation.text! = SELLERLOCATION
        SellerImage.layer.cornerRadius = SellerImage.frame.width / 2
        SellerImage.layer.masksToBounds = true
        SellerImage.setImageWith(URL(string: SELLERIMAGE)!)
        
        ViewList()
        getSold()
    }
    
    @IBAction func ButtonWhatsapp(_ sender: Any) {
        let urlWhats = "whatsapp://send?phone=" + "+6" + SELLERPHONE
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
                    print("Install Whatsapp")
                }
            }
        }
    }
    
    func getSold(){
        let parameters: Parameters=[
            "seller_id": SELLERID1,
        ]
        
        Alamofire.request(URL_READ_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        self.SOLD = ItemID
                        self.Sold.text! = String(self.SOLD.count)
                        
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func ViewList(){
        let parameters: Parameters=[
            "user_id": SELLERID1,
        ]
        
        Alamofire.request(URL_READALL_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        let Seller_ID = user.value(forKey: "user_id") as! [String]
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID = ItemID
                        self.SELLERID = Seller_ID
                        self.MAINCATE = Main_Cate
                        self.SUBCATE = Sub_Cate
                        self.ADDETAIL = Ad_Detail
                        self.BRAND = brand_mat
                        self.INNER = inner_mat
                        self.STOCK = stock
                        self.DESC = description
                        self.PRICE = Price
                        self.PHOTO = Photo
                        self.RATING = rating
                        self.DIVISION = Division
                        self.DISTRICT = District
                        
                        self.Products.text! = String(self.ITEMID.count)
                        
                        self.AboutSellerView.reloadData()
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutSellerCollectionViewCell", for: indexPath) as! AboutSellerCollectionViewCell
        
        cell.ItemName.text! = self.ADDETAIL[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.PRICE[indexPath.row]
        cell.ItemLocation.text! = self.DISTRICT[indexPath.row]
        cell.ButtonView.layer.cornerRadius = 5
        return cell
    }
    
    func onViewClick(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = UserID
        viewProduct.ItemID = self.ITEMID[indexPath.row]
        viewProduct.SELLERID = self.SELLERID[indexPath.row]
        viewProduct.MAINCATE = self.MAINCATE[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATE[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAIL[indexPath.row]
        viewProduct.BRAND = self.BRAND[indexPath.row]
        viewProduct.INNER = self.INNER[indexPath.row]
        viewProduct.STOCK = self.STOCK[indexPath.row]
        viewProduct.DESC = self.DESC[indexPath.row]
        viewProduct.PRICE = self.PRICE[indexPath.row]
        viewProduct.PHOTO = self.PHOTO[indexPath.row]
        viewProduct.DIVISION = self.DIVISION[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICT[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    func onAddToFav(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
                    return
                }
                
                let parameters: Parameters=[
                    "seller_id": self.SELLERID[indexPath.row],
                    "item_id": self.ITEMID[indexPath.row],
                    "customer_id": UserID,
                    "main_category": self.MAINCATE[indexPath.row],
                    "sub_category": self.SUBCATE[indexPath.row],
                    "ad_detail": self.ADDETAIL[indexPath.row],
                    "brand_material":self.BRAND[indexPath.row],
                    "inner_material": self.INNER[indexPath.row],
                    "stock": self.STOCK[indexPath.row],
                    "description": self.DESC[indexPath.row],
                    "price": self.PRICE[indexPath.row],
                    "rating": self.RATING[indexPath.row],
                    "division": self.DIVISION[indexPath.row],
                    "district": self.DISTRICT[indexPath.row],
                    "photo": self.PHOTO[indexPath.row]
                ]
                
                //Sending http post request
                Alamofire.request(URL_ADD_FAV, method: .post, parameters: parameters).responseJSON
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
    
    func onAddToCart(cell: AboutSellerCollectionViewCell) {
        guard let indexPath = self.AboutSellerView.indexPath(for: cell) else{
                    return
                }
                
                let parameters: Parameters=[
                    "seller_id": self.SELLERID[indexPath.row],
                    "item_id": self.ITEMID[indexPath.row],
                    "customer_id": UserID,
                    "main_category": self.MAINCATE[indexPath.row],
                    "sub_category": self.SUBCATE[indexPath.row],
                    "ad_detail": self.ADDETAIL[indexPath.row],
                    "price": self.PRICE[indexPath.row],
                    "quantity": "1",
                    "division": self.DIVISION[indexPath.row],
                    "district": self.DISTRICT[indexPath.row],
                    "photo": self.PHOTO[indexPath.row]
                ]
                
                //Sending http post request
                Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
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
}
