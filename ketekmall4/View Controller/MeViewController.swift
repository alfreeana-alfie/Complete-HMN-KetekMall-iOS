//
//  MeViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking

class MeViewController: UIViewController {
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var verify: UILabel!
    
    var userID: String = ""
    let sharedPref = UserDefaults.standard
    var user: String = ""
    var email: String = ""
    var name: String = ""
    
    @IBAction func MyBuying(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "MyBuyingViewController") as! MyBuyingViewController
        myBuying.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    @IBAction func MyRating(_ sender: Any) {
        let myRating = self.storyboard!.instantiateViewController(identifier: "MyRatingViewController") as! MyRatingViewController
        myRating.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myRating, animated: true)
        }
    }
    
    @IBAction func MyLikes(_ sender: Any) {
        let myLikes = self.storyboard!.instantiateViewController(identifier: "MyLikesViewController") as! MyLikesViewController
        myLikes.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myLikes, animated: true)
        }
    }
    
    @IBAction func AccountSettings(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(identifier: "AccountSettingsViewController") as! AccountSettingsViewController
        accountsettings.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    @IBAction func MySelling(_ sender: Any) {
        let myselling = self.storyboard!.instantiateViewController(identifier: "MySellingViewController") as! MySellingViewController
        myselling.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myselling, animated: true)
        }
    }
    
    @IBAction func AddProduct(_ sender: Any) {
        let addproduct = self.storyboard!.instantiateViewController(identifier: "AddNewProductViewController") as! AddNewProductViewController
               addproduct.userID = userID
               if let navigator = self.navigationController {
                   navigator.pushViewController(addproduct, animated: true)
               }
    }
    
    
    @IBAction func MyProducts(_ sender: Any) {
        let accountsettings = self.storyboard!.instantiateViewController(identifier: "MyProductsCollectionViewController") as! MyProductsCollectionViewController
        accountsettings.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(accountsettings, animated: true)
        }
    }
    
    @IBAction func MyIncome(_ sender: Any) {
        let myincome = self.storyboard!.instantiateViewController(identifier: "MyIncomeViewController") as! MyIncomeViewController
        myincome.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(myincome, animated: true)
        }
    }
    
    
    @IBAction func ProductRating(_ sender: Any) {
        let productrating = self.storyboard!.instantiateViewController(identifier: "ProductRatingViewController") as! ProductRatingViewController
        productrating.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(productrating, animated: true)
        }
    }
    
    @IBAction func BoostAd(_ sender: Any) {
        let boostAd = self.storyboard!.instantiateViewController(identifier: "BoostAdViewController") as! BoostAdViewController
        boostAd.userID = userID
        if let navigator = self.navigationController {
            navigator.pushViewController(boostAd, animated: true)
        }
    }
    
    @IBAction func didTapGoogle(sender: AnyObject) {
        UIApplication.shared.openURL(NSURL(string: "https://ketekmall.com")! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        
        let tabbar = tabBarController as! BaseTabBarController
        //        Value.text = tabbar.value
        userID = tabbar.value
        
        let parameters: Parameters=[
            "id": userID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let verify = user.value(forKey: "verification") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.username.text = name[0]
                        if verify[0] == "1" {
                            self.verify.text = "SELLER"
                        }else{
                            self.verify.text = "BUYER"
                        }
                        
                        self.userImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
}
