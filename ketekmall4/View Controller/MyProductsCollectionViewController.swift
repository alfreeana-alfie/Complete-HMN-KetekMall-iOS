//
//  MyProductsCollectionViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 28/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class MyProductsCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyProductDelegate{
    
    var userID: String = ""
    let URL_READ = "https://ketekmall.com/ketekmall/readuser.php";
    let URL_REMOVE = "https://ketekmall.com/ketekmall/delete_item.php";
    let URL_EDIT_BOOST = "https://ketekmall.com/ketekmall/edit_boost_ad.php";
    
    @IBOutlet var productView: UICollectionView!
    
    var category = ["Cake and pastries", "Process food", "Handicraft", "Retail and Wholesale", "Agriculture", "Service", "Health and Beauty", "home and living", "Fashion Accessories", "Sarawak - Based Product"]
    
    var ad_Detail: [String] = []
    var price: [String] = []
    var location: [String] = []
    var ItemPhoto: [String] = []
    var ItemID: [String] = []
    
    var MAINCATE: [String] = []
    var SUBCATE: [String] = []
    var BRAND: [String] = []
    var INNER: [String] = []
    var STOCK: [String] = []
    var DESC: [String] = []
    var MAXORDER: [String] = []
    var DIVISION: [String] = []
    //    var RATING: [String] = []
    //        var ITEMID: String = ""
    //        var ADDETAIL: String = ""
    //        var PRICE: String = ""
    //        var PHOTO: String = ""
    //        var DISTRICT: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productView.delegate = self
        self.productView.dataSource = self
        
        navigationItem.title = "My Products"
        let parameters: Parameters=[
            "user_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let userID = user.value(forKey: "user_id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Location = user.value(forKey: "district") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let ID = user.value(forKey: "id") as! [String]
                        
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        //                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        let max_order = user.value(forKey: "max_order") as! [String]
                        //                        let rating = user.value(forKey: "rating") as! [String]
                        //                        let Price = user.value(forKey: "price") as! [String]
                        //                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        //                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ItemID = ID
                        self.ad_Detail = AdDetail
                        self.price = Price
                        self.location = Location
                        self.ItemPhoto = Photo
                        self.MAINCATE = Main_Cate
                        self.SUBCATE = Sub_Cate
                        self.MAXORDER = max_order
                        self.BRAND = brand_mat
                        self.INNER = inner_mat
                        self.STOCK = stock
                        self.DESC = description
                        self.DIVISION = Division
                        

                        self.productView.reloadData()
                        
                    }
                }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProductsCollectionViewCell", for: indexPath) as! MyProductsCollectionViewCell
        
        let NEWIm = self.ItemPhoto[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.price[indexPath.row]
        cell.ItemLocation.text! = self.location[indexPath.row]
        cell.Btn_Edit.layer.cornerRadius = 5
        cell.Btn_Edit.layer.borderWidth = 1
        cell.Btn_Boost.layer.cornerRadius = 5
        cell.Btn_Boost.layer.borderWidth = 1
        cell.Btn_Cancel.layer.cornerRadius = 5
        cell.Btn_Cancel.layer.borderWidth = 1
        
        cell.delegate = self
        return cell
    }
    
    func btnRemove(cell: MyProductsCollectionViewCell) {
        guard let indexPath = self.productView.indexPath(for: cell) else{
            return
        }
        
        let ID = self.ItemID[indexPath.row]
        let parameters: Parameters=[
            "id": ID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_REMOVE, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                //                print(response)
                
                //getting the json value from the server
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SUCCESS")
                    }
                }
        }
    }
    
    func btnEdit(cell: MyProductsCollectionViewCell) {
        guard let indexPath = self.productView.indexPath(for: cell) else{
            return
        }
        
        let ProductView = self.storyboard!.instantiateViewController(identifier: "EditProductViewController") as! EditProductViewController
        //        let ID = self.ItemID[indexPath.row]
        ProductView.USERID = userID
        ProductView.ITEMID = self.ItemID[indexPath.row]
        ProductView.ADDETAIL = self.ad_Detail[indexPath.row]
        ProductView.MAINCATE = self.MAINCATE[indexPath.row]
        ProductView.SUBCATE = self.SUBCATE[indexPath.row]
        ProductView.PRICE = self.price[indexPath.row]
        ProductView.BRAND = self.BRAND[indexPath.row]
        ProductView.INNER = self.INNER[indexPath.row]
        ProductView.STOCK = self.STOCK[indexPath.row]
        ProductView.DESC = self.DESC[indexPath.row]
        ProductView.DIVISION = self.DIVISION[indexPath.row]
        ProductView.DISTRICT = self.location[indexPath.row]
        ProductView.PHOTO = self.ItemPhoto[indexPath.row]
        ProductView.MAXORDER = self.MAXORDER[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(ProductView, animated: true)
        }
    }
    
    func btnBoost(cell: MyProductsCollectionViewCell) {
        guard let indexPath = self.productView.indexPath(for: cell) else{
            return
        }
        
        let ID = self.ItemID[indexPath.row]
        let parameters: Parameters=[
            "id": ID,
            "user_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_REMOVE, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        print("SUCCESS")
                    }
                }
        }
        
    }
}
