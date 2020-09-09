//
//  EditProductAdDetailViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

class EditProductAdDetailViewController: UIViewController {
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.AdDetail.text! = ADDETAIL
        self.BrandMaterial.text! = BRAND
        self.InnerMaterial.text! = INNER
        self.Stock.text! = STOCK
        self.Description.text! = DESC
        
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
    @IBAction func Accept(_ sender: Any) {
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
    
    @IBAction func Cancel(_ sender: Any) {
         _ = navigationController?.popViewController(animated: true)
    }

}
