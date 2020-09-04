//
//  ViewReviewViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class ViewReviewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_review.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var ITEMID: String = ""
    
    var REVIEWID: [String] = []
    var USERNAME: [String] = []
    var REVIEW: [String] = []

    
    @IBOutlet weak var ReviewView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ReviewView.delegate = self
        ReviewView.dataSource = self
        
        let parameters: Parameters=[
            "item_id": ITEMID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let review_id = user.value(forKey: "id") as! [String]
                        let username = user.value(forKey: "customer_name") as! [String]
                        let review = user.value(forKey: "review") as! [String]
                        
                        self.REVIEWID = review_id
                        self.USERNAME = username
                        self.REVIEW = review
                        
                        self.ReviewView.reloadData()
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return REVIEWID.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell
        
        cell.UserImage.setImageWith(URL(string: MAIN_PHOTO)!)
        cell.UserImage.layer.cornerRadius = cell.UserImage.frame.width / 2
        cell.UserName.text! = self.USERNAME[indexPath.row]
        cell.Review.text! = self.REVIEW[indexPath.row]
        return cell
    }
}
