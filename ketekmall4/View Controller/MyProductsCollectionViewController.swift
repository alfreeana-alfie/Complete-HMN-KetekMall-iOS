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
    
    @IBOutlet var productView: UICollectionView!
    
    var category = ["Cake and pastries", "Process food", "Handicraft", "Retail and Wholesale", "Agriculture", "Service", "Health and Beauty", "home and living", "Fashion Accessories", "Sarawak - Based Product"]
    
    var ad_Detail: [String] = []
    var price: [String] = []
    var location: [String] = []
    var ItemPhoto: [String] = []
    var ItemID: [String] = []
    
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
                        
                        self.ItemID = ID
                        self.ad_Detail = AdDetail
                        self.price = Price
                        self.location = Location
                        self.ItemPhoto = Photo
                        
                        print(Photo)
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
        
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.price[indexPath.row]
        cell.ItemLocation.text! = self.location[indexPath.row]
        print(self.ItemPhoto[indexPath.row])
        
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
        
        let ProductView = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        let ID = self.ItemID[indexPath.row]
        ProductView.ItemID = ID
        if let navigator = self.navigationController {
            navigator.pushViewController(ProductView, animated: true)
        }
    }
}
