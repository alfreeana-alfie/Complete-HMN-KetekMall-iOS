//
//  EditProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class EditProductViewController: UIViewController {
    
    let URL_UPLOAD = "https://ketekmall.com/ketekmall/edituser.php"
    let URL_IMG = "https://ketekmall.com/ketekmall/uploadimg02.php"    
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var UploadImage: UIButton!
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var AdDetail: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var Max_Order: UITextField!
    
//    var SELLERID: [String] = []
    var MAINCATE: String = ""
    var SUBCATE: String = ""
    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var MAXORDER: String = ""
    var DIVISION: String = ""
//    var RATING: [String] = []
    var ITEMID: String = ""
    var ADDETAIL: String = ""
    var PRICE: String = ""
    var PHOTO: String = ""
    var DISTRICT: String = ""
    var USERID: String = ""
    
    @IBAction func SetupDelivery(_ sender: Any) {
    }
    
    
    @IBAction func Uploading(_ sender: Any) {
    }
    
    @IBAction func Accpt(_ sender: Any) {
//        let imageData: Data = UploadPhoto.image!.pngData()!
//        let imageStr: String = imageData.base64EncodedString()
//
        let parameters: Parameters=[
            "user_id": USERID,
            "main_category":Category.text!,
            "sub_category":Category.text!,
            "ad_detail":ADDETAIL,
            "brand_material":BRAND,
            "inner_material": INNER,
            "stock": STOCK,
            "description": DESC,
            "price": Price.text!,
            "max_order": Max_Order.text!,
            "division": Division.text!,
            "district": District.text!,
        ]
        
        //Sending http post request
        Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Category.text! = MAINCATE
        Price.text! = PRICE
        Division.text! = DIVISION
        District.text! = DISTRICT
        Max_Order.text! = MAXORDER
        
    }
}
