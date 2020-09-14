//
//  ProductRatingViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class ProductRatingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 163
            return CGSize(width: cellSquareSize, height: cellSquareHeight);
        }
           
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductRatingCollectionViewCell", for: indexPath) as! ProductRatingCollectionViewCell
        
        let NEWIm = self.item_image[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        cell.AdDetail.text! = self.ad_detail[indexPath.row]
        cell.UserName.text! = self.customer_name[indexPath.row]
        cell.UserImage.setImageWith(URL(string: Customer_Image)!)
        cell.Description.text! = self.customer_review[indexPath.row]
        if let n = NumberFormatter().number(from: self.customer_rating[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        return cell
    }
    
    @IBOutlet var ProductRatingView: UICollectionView!
    private let spinner = JGProgressHUD(style: .dark)
    
    var userID: String = ""
    var ItemID: String = ""
    var AdDetailSIngle: String = ""
    var CustomerImage: String = ""
    var CustomerName: String = ""
    var CustomerReview: String = ""
    var CustomerRating: String = ""
    
    let URL_READ_PRODUCT = "https://ketekmall.com/ketekmall/read_products_review.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review_seller.php"
    
    var item_id: [String] = []
    var ad_detail: [String] = []
    var ad_detail1: [String] = []
    var item_image: [String] = []
    var customer_name: [String] = []
    var customer_review: [String] = []
    var customer_rating: [String] = []
    
    let Customer_Image = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductRatingView.delegate = self
        ProductRatingView.dataSource = self
        
        navigationItem.title = "Product Rating"
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "seller_id": userID,
        ]
        
        Alamofire.request(URL_READ_REVIEW, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value as? Dictionary<String,Any>{
                    if let list = result["read"] as? [Dictionary<String,Any>]{
                        self.spinner.dismiss(afterDelay: 3.0)
                        for i in list{
                            self.ItemID = i["item_id"] as! String
                            self.CustomerName = i["customer_name"] as! String
                            self.CustomerReview = i["review"] as! String
                            self.CustomerRating = i["rating"] as! String
                            
                            self.item_id.append(self.ItemID)
                            self.customer_name.append(self.CustomerName)
                            self.customer_review.append(self.CustomerReview)
                            self.customer_rating.append(self.CustomerRating)
                            
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
