//
//  MyLikesViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

class MyLikesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, MyLikesDelegate {
    @IBOutlet weak var MyLikesView: UICollectionView!
    
    var userID: String = ""
    
    let URL_READ = "https://ketekmall.com/ketekmall/readfav.php"
    let URL_DELETE = "https://ketekmall.com/ketekmall/delete_fav.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var ItemID: [String] = []
    var ad_Detail: [String] = []
    var price: [String] = []
    var location: [String] = []
    var ItemPhoto: [String] = []
    var RATING: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyLikesView.delegate = self
        MyLikesView.dataSource = self
        
        navigationItem.title = "My Likes"
        let parameters: Parameters=[
            "customer_id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let ID = user.value(forKey: "id") as! [String]
                        let AdDetail = user.value(forKey: "ad_detail") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Location = user.value(forKey: "district") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.ItemID = ID
                        self.ad_Detail = AdDetail
                        self.price = Price
                        self.location = Location
                        self.ItemPhoto = Photo
                        self.RATING = rating
                        
//                        print(Photo)
                        self.MyLikesView.reloadData()
                        
                    }
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_Detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyLikesCollectionViewCell", for: indexPath) as! MyLikesCollectionViewCell
        let NEWIm = self.ItemPhoto[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.ItemName.text! = self.ad_Detail[indexPath.row]
        cell.ItemPrice.text! = "MYR" + self.price[indexPath.row]
        cell.ItemLocation.text! = self.location[indexPath.row]
        
        cell.BtnView.layer.cornerRadius = 5
        cell.BtnRemove.layer.cornerRadius = 5
        
        if let n = NumberFormatter().number(from: self.RATING[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.RatingBar.value = f
        }
        cell.delegate = self
        
        return cell
    }
    
    func btnVIEW(cell: MyLikesCollectionViewCell) {
        guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
            return
        }
        
        let ViewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        let ID = self.ItemID[indexPath.row]
        ViewProduct.ItemID = ID
        if let navigator = self.navigationController {
            navigator.pushViewController(ViewProduct, animated: true)
        }
    }
    
    func btnRemove(cell: MyLikesCollectionViewCell) {
        guard let indexPath = self.MyLikesView.indexPath(for: cell) else{
            return
        }
        
        let ID = self.ItemID[indexPath.row]
        let parameters: Parameters=[
                    "id": ID,
                ]
                
                //Sending http post request
                Alamofire.request(URL_DELETE, method: .post, parameters: parameters).responseJSON
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
}
