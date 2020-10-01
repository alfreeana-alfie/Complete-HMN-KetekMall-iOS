//
//  EditProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 02/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import ImagePicker

class EditProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let URL_UPLOAD = "https://ketekmall.com/ketekmall/edituser.php"
    let URL_IMG = "https://ketekmall.com/ketekmall/uploadimg02.php"
    let URL_UPLOAD_EXTRA = "https://ketekmall.com/ketekmall/products_img/uploadimg03.php"
    let URL_READ_PHOTO = "https://ketekmall.com/ketekmall/products_img/read_photo.php"
    let URL_EDIT_PROD = "https://ketekmall.com/ketekmall/edit_product_detail.php"
    let URL_DELETE_PHOTO = "https://ketekmall.com/ketekmall/products_img/delete_photo.php"
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemImage2: UIImageView!
    @IBOutlet weak var ItemImage3: UIImageView!
    @IBOutlet weak var ItemImage4: UIImageView!
    @IBOutlet weak var ItemImage5: UIImageView!
    
    @IBOutlet weak var Delete_2: UIButton!
    @IBOutlet weak var Delete_3: UIButton!
    @IBOutlet weak var Delete_4: UIButton!
    @IBOutlet weak var Delete_5: UIButton!
    
    
    @IBOutlet weak var UploadImage: UIButton!
    @IBOutlet weak var Category: UITextField!
    
    @IBOutlet weak var UploadedPhotoLabel: UILabel!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var AdDetailLabel: UILabel!
    @IBOutlet weak var ButtonSetupDelivery: UIButton!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var DivisionLabel: UILabel!
    @IBOutlet weak var DistrictLabel: UILabel!
    @IBOutlet weak var MaxOrderLabel: UILabel!
    @IBOutlet weak var ButtonAdDetail: UIButton!
    @IBOutlet weak var SetupDeliveryLabel: UILabel!
    
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var Max_Order: UITextField!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    @IBOutlet weak var CategoryView: UIView!
    @IBOutlet weak var ProdDetailView: UIView!
    @IBOutlet weak var PriceView: UIView!
    @IBOutlet weak var DivisionView: UIView!
    @IBOutlet weak var DistrictView: UIView!
    @IBOutlet weak var MaxOrderView: UIView!
    @IBOutlet weak var DeliveryView: UIView!
    
    var viewController1: UIViewController?
    
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
    
    var flag = 0
    
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
        
        let NEWIm = PHOTO.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        Category.text! = MAINCATE
        Price.text! = PRICE
        Division.text! = DIVISION
        District.text! = DISTRICT
        Max_Order.text! = MAXORDER
        
        saveItemID()
        ViewPhoto()
        
        ButtonAccept.layer.cornerRadius = 7
        ButtonCancel.layer.cornerRadius = 7
        UploadImage.layer.cornerRadius = 7
        
        Delete_2.isHidden = true
        Delete_3.isHidden = true
        Delete_4.isHidden = true
        Delete_5.isHidden = true
        
        //        ButtonAccept.layer.maskedCorners = [.layerMaxXMinYCorner]
        //        ButtonCancel.layer.maskedCorners = [.layerMinXMinYCorner]
        
        //        ButtonAdDetail.layer.cornerRadius = 5
        //        ButtonAdDetail.layer.borderWidth = 0.1
        
        //        ButtonSetupDelivery.layer.cornerRadius = 5
        //        ButtonSetupDelivery.layer.borderWidth = 0.1
        
        ItemImage.layer.cornerRadius = 7
        ItemImage2.layer.cornerRadius = 7
        ItemImage3.layer.cornerRadius = 7
        ItemImage4.layer.cornerRadius = 7
        ItemImage5.layer.cornerRadius = 7
        
        Delete_2.layer.cornerRadius = 7
        Delete_3.layer.cornerRadius = 7
        Delete_4.layer.cornerRadius = 7
        Delete_5.layer.cornerRadius = 7
        
        CategoryView.layer.cornerRadius = 7
        ProdDetailView.layer.cornerRadius = 7
        PriceView.layer.cornerRadius = 7
        DivisionView.layer.cornerRadius = 7
        DistrictView.layer.cornerRadius = 7
        MaxOrderView.layer.cornerRadius = 7
        DeliveryView.layer.cornerRadius = 7
        
        ItemImage.isUserInteractionEnabled = true
        ItemImage2.isUserInteractionEnabled = true
        ItemImage3.isUserInteractionEnabled = true
        ItemImage4.isUserInteractionEnabled = true
        ItemImage5.isUserInteractionEnabled = true
        
        let Image1 = UITapGestureRecognizer(target: self, action: #selector(selectImage1(sender:)))
        let Image2 = UITapGestureRecognizer(target: self, action: #selector(selectImage2(sender:)))
        let Image3 = UITapGestureRecognizer(target: self, action: #selector(selectImage3(sender:)))
        let Image4 = UITapGestureRecognizer(target: self, action: #selector(selectImage4(sender:)))
        let Image5 = UITapGestureRecognizer(target: self, action: #selector(selectImage5(sender:)))
        
        ItemImage.addGestureRecognizer(Image1)
        ItemImage2.addGestureRecognizer(Image2)
        ItemImage3.addGestureRecognizer(Image3)
        ItemImage4.addGestureRecognizer(Image4)
        ItemImage5.addGestureRecognizer(Image5)
    }
    
    func changeLanguage(str: String){
        UploadedPhotoLabel.text = "Upload Image".localized(lang: str)
        CategoryLabel.text = "Category".localized(lang: str)
        PriceLabel.text = "Price".localized(lang: str)
        DivisionLabel.text = "Division".localized(lang: str)
        DistrictLabel.text = "District".localized(lang: str)
        MaxOrderLabel.text = "Max Order".localized(lang: str)
        SetupDeliveryLabel.text = "Setup Delivery".localized(lang: str)
        //        UploadImage.titleLabel?.text = "Upload Image".localized(lang: str)
        
        UploadImage.setTitle("Upload Image".localized(lang: str), for: .normal)
        
        Category.placeholder = "Category".localized(lang: str)
        //        ButtonAdDetail.titleLabel?.text = "Ad Detail".localized(lang: str)
        Price.placeholder = "Price".localized(lang: str)
        Division.placeholder = "Division".localized(lang: str)
        District.placeholder = "District".localized(lang: str)
        Max_Order.placeholder = "Max Order".localized(lang: str)
        //        ButtonSetupDelivery.titleLabel?.text = "Setup Delivery".localized(lang: str)
        
        ButtonSetupDelivery.setTitle("Click to Edit Setup Delivery".localized(lang: str), for: .normal)
        
        //        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
        //        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
        
        ButtonAccept.setTitle("ACCEPT".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("CANCEL".localized(lang: str), for: .normal)
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
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "ad_detail":ADDETAIL,
            "photo":PHOTO,
        ]
        
        print(ADDETAIL)
        //Sending http post request
        Alamofire.request(URL_IMG, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    self.spinner.dismiss(afterDelay: 3.0)
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    @IBAction func Accpt(_ sender: Any) {
        spinner.show(in: self.view)
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
        
        Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                    self.spinner.textLabel.text = "Edit Saved"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                    _ = self.navigationController?.popViewController(animated: true)
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func DeletePhoto2(_ sender: Any) {
        ItemImage2.contentMode = .scaleAspectFill
        ItemImage2.image = UIImage(named: "Image")
//        deletePhoto(number: "2")
        Delete_2.isHidden = true
    }
    
    @IBAction func DeletePhoto3(_ sender: Any) {
        ItemImage3.contentMode = .scaleAspectFill
        ItemImage3.image = UIImage(named: "Image")
//        deletePhoto(number: "3")
        Delete_3.isHidden = true
    }
    
    @IBAction func DeletePhoto4(_ sender: Any) {
        ItemImage4.contentMode = .scaleAspectFill
        ItemImage4.image = UIImage(named: "Image")
        deletePhoto(number: "4")
        Delete_4.isHidden = true
    }
    
    @IBAction func DeletePhoto5(_ sender: Any) {
        ItemImage5.contentMode = .scaleAspectFill
        ItemImage5.image = UIImage(named: "Image")
        deletePhoto(number: "5")
        Delete_5.isHidden = true
    }
    
    
    
    func deletePhoto(number: String){
        let filename = ADDETAIL + number
        let parameters: Parameters=[
            "filename": filename,
        ]
        
        Alamofire.request(URL_DELETE_PHOTO, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    print("SUCCESS DELETE")
                    
                }else{
                    print("FAILED")
                }
        }
    }
    
    func ViewPhoto(){
        let parameters: Parameters=[
            "ad_detail": ADDETAIL
        ]
        
        Alamofire.request(URL_READ_PHOTO, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as? NSArray
                        
                        let photo = user?.value(forKey: "filepath") as? [String]
                        
                        var image: [String] = []
                        
                        image = photo!
                        
                        if(user?.count == 0 || user?.count == 1){
                            print("1")
                        }else if(user?.count == 2){
                            let newPhoto = image[1].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            self.ItemImage2.setImageWith(URL(string: newPhoto!)!)
                            
                            self.Delete_2.isHidden = false
                        }else if(user?.count == 3){
                            let newPhoto = image[1].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto2 = image[2].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            
                            self.ItemImage2.setImageWith(URL(string: newPhoto!)!)
                            self.ItemImage3.setImageWith(URL(string: newPhoto2!)!)
                            
                            self.Delete_2.isHidden = false
                            self.Delete_3.isHidden = false
                        }else if(user?.count == 4){
                            let newPhoto = image[1].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto2 = image[2].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto3 = image[3].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            
                            self.ItemImage2.setImageWith(URL(string: newPhoto!)!)
                            self.ItemImage3.setImageWith(URL(string: newPhoto2!)!)
                            self.ItemImage4.setImageWith(URL(string: newPhoto3!)!)
                            
                            self.Delete_2.isHidden = false
                            self.Delete_3.isHidden = false
                            self.Delete_4.isHidden = false
                            
                        }else if(user?.count == 5){
                            let newPhoto = image[1].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto2 = image[2].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto3 = image[3].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            let newPhoto4 = image[4].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                            
                            self.ItemImage2.setImageWith(URL(string: newPhoto!)!)
                            self.ItemImage3.setImageWith(URL(string: newPhoto2!)!)
                            self.ItemImage4.setImageWith(URL(string: newPhoto3!)!)
                            self.ItemImage5.setImageWith(URL(string: newPhoto4!)!)
                        }
                        
                        self.Delete_2.isHidden = false
                        self.Delete_3.isHidden = false
                        self.Delete_4.isHidden = false
                        self.Delete_5.isHidden = false
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func saveImage(number: String, Image: UIImageView){
        let imageData: Data = Image.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        let filename = ADDETAIL + number
        
        let parameters: Parameters=[
            "item_id": ITEMID,
            "ad_detail": ADDETAIL,
            "filename": filename,
            "filepath": imageStr,
            
        ]
        
        //Sending http post request
        Alamofire.request(URL_UPLOAD_EXTRA, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    
                }else{
                    print("FAILED")
                }
        }
    }
    
    func saveItemID(){
        let parameters: Parameters=[
            "id": ITEMID,
            "ad_detail":ADDETAIL,
        ]
        
        Alamofire.request(URL_EDIT_PROD, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    print("SUCCESS ITEM ID")
                    
                }else{
                    print("FAILED")
                }
        }
    }
    
    @objc private func uploadToServer(sender: UITapGestureRecognizer) {
        let imageData: Data = ItemImage.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        spinner.show(in: self.view)
        let parameters: Parameters=[
            "ad_detail": ADDETAIL,
            "photo": imageStr,
        ]
        
        //Sending http post request
        Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    self.spinner.dismiss(afterDelay: 3.0)
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    @objc private func selectImage1(sender: UITapGestureRecognizer) {
        flag = 1
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
            
        }
    }
    
    @objc private func selectImage2(sender: UITapGestureRecognizer) {
        flag = 2
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
            
        }
    }
    
    @objc private func selectImage3(sender: UITapGestureRecognizer) {
        flag = 3
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
            
        }
    }
    
    @objc private func selectImage4(sender: UITapGestureRecognizer) {
        flag = 4
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
            
        }
    }
    
    @objc private func selectImage5(sender: UITapGestureRecognizer) {
        flag = 5
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true){
            
        }
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
            if(flag == 1){
                ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                ItemImage.image = chosenImage
            }else if(flag == 2){
                ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                ItemImage2.image = chosenImage
            }else if(flag == 3){
                ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                ItemImage3.image = chosenImage
            }else if(flag == 4){
                ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                ItemImage4.image = chosenImage
            }else if(flag == 5){
                ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                ItemImage5.image = chosenImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
}
