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
    var name: String = ""
    var email: String = ""
    var lang: String = ""
    
    
    @IBOutlet weak var ButtonMySelling: UIButton!
    @IBOutlet weak var ButtonAddNewProduct: UIButton!
    @IBOutlet weak var ButtonMyProduct: UIButton!
    @IBOutlet weak var ButtonMyIncome: UIButton!
    @IBOutlet weak var ButtonProductRating: UIButton!
    @IBOutlet weak var ButtonBoostAd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        print(lang)
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        user = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
        userID = String(user)
        
    }
    
    func changeLanguage(str: String){
        ButtonMySelling.setTitle("My Selling".localized(lang: str), for: .normal)
        ButtonAddNewProduct.setTitle("Add New Product".localized(lang: str), for: .normal)
        ButtonMyProduct.setTitle("My Products".localized(lang: str), for: .normal)
        ButtonMyIncome.setTitle("My Income".localized(lang: str), for: .normal)
        ButtonProductRating.setTitle("Product Rating".localized(lang: str), for: .normal)
        ButtonBoostAd.setTitle("Boost Ad".localized(lang: str), for: .normal)
        
//        ButtonMySelling.titleLabel?.text = "My Selling".localized(lang: str)
//        ButtonAddNewProduct.titleLabel?.text = "Add New Product".localized(lang: str)
//        ButtonMyProduct.titleLabel?.text = "My Products".localized(lang: str)
//        ButtonMyIncome.titleLabel?.text = "My Income".localized(lang: str)
//        ButtonProductRating.titleLabel?.text = "Product Rating".localized(lang: str)
//        ButtonBoostAd.titleLabel?.text = "Boost Ad".localized(lang: str)
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
