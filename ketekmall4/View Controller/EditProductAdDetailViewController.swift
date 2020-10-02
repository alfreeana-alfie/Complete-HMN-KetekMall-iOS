//
//  EditProductAdDetailViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class EditProductAdDetailViewController: UIViewController {
    
    @IBOutlet weak var AdDetailLabel: UILabel!
    @IBOutlet weak var BrandLabel: UILabel!
    @IBOutlet weak var InnerLabel: UILabel!
    @IBOutlet weak var StockLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var AdDetail: UITextField!
    @IBOutlet weak var BrandMaterial: UITextField!
    @IBOutlet weak var InnerMaterial: UITextField!
    @IBOutlet weak var Stock: UITextField!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    var MAINCATE: String = ""
        var SUBCATE: String = ""
        var BRAND: String = ""
        var INNER: String = ""
        var STOCK: String = ""
        var DESC: String = ""
        var MAXORDER: String = ""
        var DIVISION: String = ""
        var ITEMID: String = ""
        var ADDETAIL: String = ""
        var PRICE: String = ""
        var PHOTO: String = ""
        var DISTRICT: String = ""
        var USERID: String = ""
    var CheckView: Bool = false
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        self.AdDetail.text! = ADDETAIL
        self.BrandMaterial.text! = BRAND
        self.InnerMaterial.text! = INNER
        self.Stock.text! = STOCK
        self.Description.text! = DESC
        
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
    func changeLanguage(str: String){
        AdDetailLabel.text = "Ad Detail".localized(lang: str)
        BrandLabel.text = "Brand Material".localized(lang: str)
        InnerLabel.text = "Inner Material".localized(lang: str)
        StockLabel.text = "Stock".localized(lang: str)
        DescriptionLabel.text = "Description".localized(lang: str)
        
        AdDetail.placeholder = "Ad Detail".localized(lang: str)
        BrandMaterial.placeholder = "Brand Material".localized(lang: str)
        InnerMaterial.placeholder = "Inner Material".localized(lang: str)
        Stock.placeholder = "Stock".localized(lang: str)
        Description.placeholder = "Description".localized(lang: str)
        
        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
    }
    
    @IBAction func Accept(_ sender: Any) {
        if(CheckView == true){
            let AdDetail = self.storyboard!.instantiateViewController(identifier: "AddNewProductViewController") as! AddNewProductViewController
            AdDetail.userID = USERID
            AdDetail.Addetail = self.AdDetail.text!
            AdDetail.Category.text! = MAINCATE
            AdDetail.Category.text! = SUBCATE
            AdDetail.Price.text! = PRICE
            AdDetail.BrandMaterial = self.BrandMaterial.text!
            AdDetail.InnerMaterial = self.InnerMaterial.text!
            AdDetail.Stock = self.Stock.text!
            AdDetail.Description = self.Description.text!
            AdDetail.Division.text! = DIVISION
            AdDetail.District.text! = DISTRICT
            AdDetail.MaxOrder.text! = MAXORDER
            if let navigator = self.navigationController {
                navigator.pushViewController(AdDetail, animated: true)
            }
        }else{
            let AdDetail = self.storyboard!.instantiateViewController(identifier: "EditProductViewController") as! EditProductViewController
            AdDetail.USERID = USERID
            AdDetail.ITEMID = ITEMID
            AdDetail.ADDETAIL = self.AdDetail.text!
            AdDetail.MAINCATE = MAINCATE
            AdDetail.SUBCATE = SUBCATE
            AdDetail.PRICE = PRICE
            AdDetail.BRAND = self.BrandMaterial.text!
            AdDetail.INNER = self.InnerMaterial.text!
            AdDetail.STOCK = self.Stock.text!
            AdDetail.DESC = self.Description.text!
            AdDetail.DIVISION = DIVISION
            AdDetail.DISTRICT = DISTRICT
            AdDetail.PHOTO = PHOTO
            AdDetail.MAXORDER = MAXORDER
            if let navigator = self.navigationController {
                navigator.pushViewController(AdDetail, animated: true)
            }
        }
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }

}
