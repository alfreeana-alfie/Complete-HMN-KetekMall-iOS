//
//  ProductRatingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ProductRatingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductRatingCollectionViewCell", for: indexPath) as! ProductRatingCollectionViewCell
        
        cell.AdDetail.text! = self.ad_detail[indexPath.row]
        cell.UserName.text! = self.customer_name[indexPath.row]
        cell.UserImage.setImageWith(URL(string: Customer_Image)!)
        cell.Description.text! = self.customer_review[indexPath.row]
        return cell
    }
    
    @IBOutlet var ProductRatingView: UICollectionView!
    
    var userID: String = ""
    var ItemID: String = ""
    var AdDetailSIngle: String = ""
    var CustomerImage: String = ""
    var CustomerName: String = ""
    var CustomerReview: String = ""
    
    let URL_READ_PRODUCT = "https://ketekmall.com/ketekmall/read_products_review.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review_seller.php"
    
    var item_id: [String] = []
    var ad_detail: [String] = []
    var ad_detail1: [String] = []
    var item_image: [String] = []
    var customer_name: [String] = []
    var customer_review: [String] = []
    
    let Customer_Image = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductRatingView.delegate = self
        ProductRatingView.dataSource = self
        
        navigationItem.title = "Product Rating"
        let parameters: Parameters=[
            "seller_id": userID,
        ]
        
        Alamofire.request(URL_READ_REVIEW, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        for i in list{
                            self.ItemID = i["item_id"] as! String
                            self.CustomerName = i["customer_name"] as! String
                            self.CustomerReview = i["review"] as! String
                            
                            self.item_id.append(self.ItemID)
                            self.customer_name.append(self.CustomerName)
                            self.customer_review.append(self.CustomerReview)
                            
                            let parameters1: Parameters=[
                                "id": self.ItemID,
                            ]
                            
                            Alamofire.request(self.URL_READ_PRODUCT, method: .post, parameters: parameters1).responseJSON
                                {
                                    response in
                                    if let result = response.result.value as? Dictionary<String,Any>{
                                        if let list = result["read"] as? [Dictionary<String,Any>]{
                                            for i in list{
                                                self.AdDetailSIngle = i["ad_detail"] as! String
                                                self.CustomerImage = i["photo"] as! String
                                                
                                                self.item_image.append(self.CustomerImage)
                                                self.ad_detail.append(self.AdDetailSIngle)
//                                                print(self.item_image)
                                            
                                                self.ProductRatingView.reloadData()
                                            }
                                        }
                                        
                                    }
                                    
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                
        }
    }
}
