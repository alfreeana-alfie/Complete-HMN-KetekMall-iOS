//
//  SellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 05/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class SellerViewController: UIViewController {
    
    var userID: String = ""
    let sharedPref = UserDefaults.standard
    var user: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = sharedPref.string(forKey: "USERID") ?? "0"
        userID = String(user)
        
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
    
}
