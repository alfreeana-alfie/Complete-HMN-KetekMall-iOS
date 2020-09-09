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
    
    
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var Max_Order: UITextField!
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
        
        Category.text! = MAINCATE
        Price.text! = PRICE
        Division.text! = DIVISION
        District.text! = DISTRICT
        Max_Order.text! = MAXORDER
        
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        UploadImage.layer.cornerRadius = 5
        
        ItemImage.isUserInteractionEnabled = true
        let FindClick = UITapGestureRecognizer(target: self, action: #selector(selectImage(sender:)))
        
        ItemImage.addGestureRecognizer(FindClick)
    }
    
    @IBAction func AdDetail(_ sender: Any) {
        let AdDetail = self.storyboard!.instantiateViewController(identifier: "EditProductAdDetailViewController") as! EditProductAdDetailViewController
        AdDetail.USERID = USERID
        AdDetail.ITEMID = ITEMID
        AdDetail.ADDETAIL = ADDETAIL
        AdDetail.MAINCATE = MAINCATE
        AdDetail.SUBCATE = SUBCATE
        AdDetail.PRICE = PRICE
        AdDetail.BRAND = BRAND
        AdDetail.INNER = INNER
        AdDetail.STOCK = STOCK
        AdDetail.DESC = DESC
        AdDetail.DIVISION = DIVISION
        AdDetail.DISTRICT = DISTRICT
        AdDetail.PHOTO = PHOTO
        AdDetail.MAXORDER = MAXORDER
        if let navigator = self.navigationController {
            navigator.pushViewController(AdDetail, animated: true)
        }
    }
    
    @IBAction func SetupDelivery(_ sender: Any) {
        let myBuying = self.storyboard!.instantiateViewController(identifier: "DeliveryViewController") as! DeliveryViewController
        myBuying.userID = USERID
        myBuying.itemID = ITEMID
        myBuying.Addetail = ADDETAIL
        if let navigator = self.navigationController {
            navigator.pushViewController(myBuying, animated: true)
        }
    }
    
    
    @IBAction func Uploading(_ sender: Any) {
        let parameters: Parameters=[
            "ad_detail":ADDETAIL,
            "photo":PHOTO,
        ]
        
        print(ADDETAIL)
        //Sending http post request
        Alamofire.request(URL_IMG, method: .post, parameters: parameters).responseJSON
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
    
    @IBAction func Accpt(_ sender: Any) {
        let parameters: Parameters=[
            "id": ITEMID,
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
        
//        print(ADDETAIL)
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
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func uploadToServer(sender: UITapGestureRecognizer) {
            let imageData: Data = ItemImage.image!.pngData()!
            let imageStr: String = imageData.base64EncodedString()
        
    //           let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
    //           present(alert, animated: true, completion: nil)
            
            let parameters: Parameters=[
                "ad_detail": ADDETAIL,
                "photo": imageStr,
            ]
            
            //Sending http post request
            Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
    //            let alert = UIAlertController(title: "Success", message: "Ok", preferredStyle: .alert)
    //            self.present(alert, animated: true, completion: nil)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    
                }
            }
           }
        
        @objc private func selectImage(sender: UITapGestureRecognizer) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
         
        @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
            ItemImage.image = chosenImage
            dismiss(animated: true, completion: nil)
        }
    
}
