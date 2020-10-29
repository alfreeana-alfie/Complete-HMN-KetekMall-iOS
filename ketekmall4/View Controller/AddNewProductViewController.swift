//
//  AddNewProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 28/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class AddNewProductViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var AdDetailLabel: UILabel!
    @IBOutlet weak var DistrictLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var MaxOrderLabel: UILabel!
    @IBOutlet weak var DivisionLabel: UILabel!
    @IBOutlet weak var UploadedPhotoLabel: UILabel!
    
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var MaxOrder: UITextField!
    @IBOutlet weak var Weight: UITextField!
    @IBOutlet weak var PostCode: UITextField!
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemImage2: UIImageView!
    @IBOutlet weak var ItemImage3: UIImageView!
    @IBOutlet weak var ItemImage4: UIImageView!
    @IBOutlet weak var ItemImage5: UIImageView!
    
    @IBOutlet weak var Delete_2: UIButton!
    @IBOutlet weak var Delete_3: UIButton!
    @IBOutlet weak var Delete_4: UIButton!
    @IBOutlet weak var Delete_5: UIButton!
    
    @IBOutlet weak var ImageView1: UIView!
    @IBOutlet weak var ImageView2: UIView!
    @IBOutlet weak var ImageView3: UIView!
    @IBOutlet weak var ImageView4: UIView!
    @IBOutlet weak var ImageView5: UIView!
    
    @IBOutlet weak var UploadImage: UIButton!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    @IBOutlet weak var ButtonAdDetail: UIButton!
    
    let URL_ADD = "https://ketekmall.com/ketekmall/products/uploadimg.php";
    let URL_UPLOAD_EXTRA = "https://ketekmall.com/ketekmall/products_img/uploadimg03.php"

//    let URL_EDIT_PROD = "https://ketekmall.com/ketekmall/edit_product_detail.php"
    let URL_DELETE_PHOTO = "https://ketekmall.com/ketekmall/products_img/delete_photo.php"
    
    let category = ["Cake and pastries", "Process food", "Handicraft", "Retail and Wholesale", "Agriculture", "Service", "Health and Beauty", "home and living", "Fashion Accessories", "Sarawak - Based Product"]
    
    let division = ["Kuching", "Kota Samarahan", "Serian", "Sri Aman", "Betong", "Sarikei", "Sibu", "Mukah", "Bintulu", "Kapit", "Miri", "Limbang"]
    
    let kuching = ["Kuching", "Bau", "Lundu"]
    let samarahan = ["Kota Samarahan", "Asajaya", "Simunjan"]
    let serian = ["Serian", "Tembedu"]
    let sri_aman = ["Sri Aman", "Lubok Antu"]
    let betong = ["Betong", "Saratok", "Pusa","Kabong"]
    let sarikei = ["Sarikei", "Meradong", "Julau", "Pakan"]
    let sibu = ["Sibu", "Kanowit", "Selangau"]
    let mukah = ["Mukah", "Dalat", "Matu", "Daro", "Tanjong"]
    let bintulu = ["Bintulu", "Sebauh", "Tatau"]
    let kapit = ["Kapit", "Song", "Belaga", "Bukit Mabong"]
    let miri = ["Miri", "Marudi", "Subis", "Beluru", "Telang Usan"]
    let limbang = ["Limbang", "Lawas"]
    
    var CategoryPicker = UIPickerView()
    var DivisionPicker = UIPickerView()
    var DistrictPicker = UIPickerView()
    var userID: String = ""
    var BrandMaterial: String = ""
    var InnerMaterial: String = ""
    var Stock: String = ""
    var Description: String = ""
    var Addetail: String = ""
    
    var flag = 0
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

//    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        CategoryPicker.dataSource = self
        CategoryPicker.delegate = self
        
        DivisionPicker.dataSource = self
        DivisionPicker.delegate = self
        
        DistrictPicker.dataSource = self
        DistrictPicker.delegate = self
        
        Category.inputView = CategoryPicker
        Division.inputView = DivisionPicker
        District.inputView = DistrictPicker
        
        CreateCategoryPicker()
        CreateDivisionPicker()
        CreateDistrictPicker()
        
        ButtonAccept.layer.cornerRadius = 15
        ButtonCancel.layer.cornerRadius = 15
        UploadImage.layer.cornerRadius = 5
        ButtonAdDetail.layer.cornerRadius = 7
        
        Delete_2.isHidden = true
        Delete_3.isHidden = true
        Delete_4.isHidden = true
        Delete_5.isHidden = true
        
        ItemImage.layer.cornerRadius = 7
        ItemImage2.layer.cornerRadius = 7
        ItemImage3.layer.cornerRadius = 7
        ItemImage4.layer.cornerRadius = 7
        ItemImage5.layer.cornerRadius = 7
        
        Delete_2.layer.cornerRadius = 7
        Delete_3.layer.cornerRadius = 7
        Delete_4.layer.cornerRadius = 7
        Delete_5.layer.cornerRadius = 7
        
        ImageView1.isUserInteractionEnabled = true
        ImageView2.isUserInteractionEnabled = true
        ImageView3.isUserInteractionEnabled = true
        ImageView4.isUserInteractionEnabled = true
        ImageView5.isUserInteractionEnabled = true
        
        let Image1 = UITapGestureRecognizer(target: self, action: #selector(selectImage1(sender:)))
        let Image2 = UITapGestureRecognizer(target: self, action: #selector(selectImage2(sender:)))
        let Image3 = UITapGestureRecognizer(target: self, action: #selector(selectImage3(sender:)))
        let Image4 = UITapGestureRecognizer(target: self, action: #selector(selectImage4(sender:)))
        let Image5 = UITapGestureRecognizer(target: self, action: #selector(selectImage5(sender:)))
        
        ImageView1.addGestureRecognizer(Image1)
        ImageView2.addGestureRecognizer(Image2)
        ImageView3.addGestureRecognizer(Image3)
        ImageView4.addGestureRecognizer(Image4)
        ImageView5.addGestureRecognizer(Image5)
        
        UploadImage.addTarget(self, action: #selector(selectImage1), for: .touchUpInside)
        
        navigationItem.title = "Add New Product"
    }
    
    func ColorFunc(){
        //Button Accept
        let colorImageOne1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorImageOne2 = UIColor(hexString: "#F7B733").cgColor
        
        let ImageOneGradient = CAGradientLayer()
        ImageOneGradient.frame = ImageView1.bounds
        ImageOneGradient.colors = [colorImageOne1, colorImageOne2]
        ImageOneGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ImageOneGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ImageOneGradient.cornerRadius = 5
            ImageView1.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView2.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView3.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView4.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView5.layer.insertSublayer(ImageOneGradient, at: 0)
        
        //Button Accept
        let color1 = UIColor(hexString: "#AA076B").cgColor
        let color2 = UIColor(hexString: "#61045F").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonAccept.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
            ButtonAccept.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#BC4E9C").cgColor
        let color4 = UIColor(hexString: "#F80759").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        CategoryLabel.text = "Category".localized(lang: str)
        AdDetailLabel.text = "Ad Detail".localized(lang: str)
        PriceLabel.text = "Price".localized(lang: str)
        DivisionLabel.text = "Division".localized(lang: str)
        DistrictLabel.text = "District".localized(lang: str)
        MaxOrderLabel.text = "Max Order".localized(lang: str)
        UploadedPhotoLabel.text = "Upload Image".localized(lang: str)
        Category.placeholder = "Category".localized(lang: str)
        ButtonAdDetail.setTitle("Ad Detail".localized(lang: str), for: .normal)
        UploadImage.setTitle("Upload Image".localized(lang: str), for: .normal)
        Price.placeholder = "Price".localized(lang: str)
        Division.placeholder = "Division".localized(lang: str)
        District.placeholder = "District".localized(lang: str)
        MaxOrder.placeholder = "Max Order".localized(lang: str)
        
        ButtonAccept.setTitle("ACCEPT".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("CANCEL".localized(lang: str), for: .normal)
//        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
//        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == CategoryPicker {
            return category.count
            
        } else if pickerView == DivisionPicker{
            return division.count        }
        else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                return kuching.count
            } else if(Division.text == "Kota Samarahan"){
                return samarahan.count
            } else if(Division.text == "Serian"){
                return serian.count
            }  else if(Division.text == "Sri Aman"){
                return sri_aman.count
            } else if(Division.text == "Betong"){
                return betong.count
            } else if(Division.text == "Sarikei"){
                return sarikei.count
            }else if(Division.text == "Sibu"){
                return sibu.count
            }else if(Division.text == "Mukah"){
                return mukah.count
            }else if(Division.text == "Bintulu"){
                return bintulu.count
            }else if(Division.text == "Kapit"){
                return kapit.count
            }else if(Division.text == "Miri"){
                return miri.count
            }else if(Division.text == "Limbang"){
                return limbang.count
            }
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == CategoryPicker {
            return category[row]
            
        } else if pickerView == DivisionPicker{
            return division[row]
        }else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                return kuching[row]
            } else if(Division.text == "Kota Samarahan"){
                return samarahan[row]
            }else if(Division.text == "Serian"){
                return serian[row]
            }  else if(Division.text == "Sri Aman"){
                return sri_aman[row]
            } else if(Division.text == "Betong"){
                return betong[row]
            } else if(Division.text == "Sarikei"){
                return sarikei[row]
            }else if(Division.text == "Sibu"){
                return sibu[row]
            }else if(Division.text == "Mukah"){
                return mukah[row]
            }else if(Division.text == "Bintulu"){
                return bintulu[row]
            }else if(Division.text == "Kapit"){
                return kapit[row]
            }else if(Division.text == "Miri"){
                return miri[row]
            }else if(Division.text == "Limbang"){
                return limbang[row]
            }
        }
        
        return ""
    }
    
    @IBAction func AdDetail(_ sender: Any) {
        let AdDetail = self.storyboard!.instantiateViewController(identifier: "EditProductAdDetailViewController") as! EditProductAdDetailViewController
        AdDetail.USERID = userID
        AdDetail.ITEMID = ""
        AdDetail.ADDETAIL = Addetail
        AdDetail.MAINCATE = Category.text!
        AdDetail.SUBCATE = Category.text!
        AdDetail.PRICE = Price.text!
        AdDetail.BRAND = BrandMaterial
        AdDetail.INNER = InnerMaterial
        AdDetail.STOCK = Stock
        AdDetail.DESC = Description
        AdDetail.DIVISION = Division.text!
        AdDetail.DISTRICT = District.text!
        AdDetail.PHOTO = ""
        AdDetail.MAXORDER = MaxOrder.text!
        AdDetail.CheckView = true
        if let navigator = self.navigationController {
            navigator.pushViewController(AdDetail, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == CategoryPicker {
            Category.text = category[row]
            self.view.endEditing(false)
        } else if pickerView == DivisionPicker{
            Division.text = division[row]
            self.view.endEditing(false)
        }else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                District.text = kuching[row]
                self.view.endEditing(false)
            } else if(Division.text == "Kota Samarahan"){
                District.text = samarahan[row]
                self.view.endEditing(false)
            }else if(Division.text == "Serian"){
                District.text = serian[row]
            }  else if(Division.text == "Sri Aman"){
                District.text = sri_aman[row]
            } else if(Division.text == "Betong"){
                District.text = betong[row]
            } else if(Division.text == "Sarikei"){
                District.text = sarikei[row]
            }else if(Division.text == "Sibu"){
                District.text = sibu[row]
            }else if(Division.text == "Mukah"){
                District.text = mukah[row]
            }else if(Division.text == "Bintulu"){
                District.text = bintulu[row]
            }else if(Division.text == "Kapit"){
                District.text = kapit[row]
            }else if(Division.text == "Miri"){
                District.text = miri[row]
            }else if(Division.text == "Limbang"){
                District.text = limbang[row]
            }
            
        }
    }
    
    func CreateCategoryPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        Category.inputAccessoryView = toolbar
        Category.inputView = CategoryPicker
    }
    
    func CreateDivisionPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        Division.inputAccessoryView = toolbar
        Division.inputView = DivisionPicker
    }
    
    func CreateDistrictPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        District.inputAccessoryView = toolbar
        District.inputView = DistrictPicker
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    func saveImage(number: String, Image: UIImageView){
        let imageData: Data = Image.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        let filename = Addetail + number
        
        let parameters: Parameters=[
            "item_id": 0,
            "ad_detail": Addetail,
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
    
    @IBAction func DeletePhoto2(_ sender: Any) {
        ItemImage2.contentMode = .center
        ItemImage2.image = UIImage(named: "AddPhoto")
//        deletePhoto(number: "2")
        Delete_2.isHidden = true
    }
    
    @IBAction func DeletePhoto3(_ sender: Any) {
        ItemImage3.contentMode = .center
        ItemImage3.image = UIImage(named: "AddPhoto")
//        deletePhoto(number: "3")
        Delete_3.isHidden = true
    }
    
    @IBAction func DeletePhoto4(_ sender: Any) {
        ItemImage4.contentMode = .center
        ItemImage4.image = UIImage(named: "AddPhoto")
//        deletePhoto(number: "4")
        Delete_4.isHidden = true
    }
    
    @IBAction func DeletePhoto5(_ sender: Any) {
        ItemImage5.contentMode = .center
        ItemImage5.image = UIImage(named: "AddPhoto")
//        deletePhoto(number: "5")
        Delete_5.isHidden = true
    }
    
    @objc private func selectImage1(sender: UITapGestureRecognizer) {
            flag = 1
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        
        }
        
    @objc private func selectImage2(sender: UITapGestureRecognizer) {
            flag = 2
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
        
    @objc private func selectImage3(sender: UITapGestureRecognizer) {
            flag = 3
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
        
    @objc private func selectImage4(sender: UITapGestureRecognizer) {
            flag = 4
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
        
    @objc private func selectImage5(sender: UITapGestureRecognizer) {
            flag = 5
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
        
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
                if(flag == 1){
                    ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage.image = chosenImage
                    dismiss(animated: true, completion: nil)
                }else if(flag == 2){
                    ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage2.image = chosenImage
                    if(self.ItemImage2.image == chosenImage){
                        print("PRESENT")
                        self.Delete_2.isHidden = false
//                        saveImage(number: "2", Image: ItemImage2)
                    }else{
                        print("EMPTY")
                    }
                    dismiss(animated: true, completion: nil)
                }else if(flag == 3){
                    ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage3.image = chosenImage
                    if(self.ItemImage2.image == chosenImage){
                        print("PRESENT")
                        self.Delete_3.isHidden = false
//                        saveImage(number: "3", Image: ItemImage2)
                    }else{
                        print("EMPTY")
                    }
                    dismiss(animated: true, completion: nil)
                }else if(flag == 4){
                    ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage4.image = chosenImage
                    if(self.ItemImage2.image == chosenImage){
                        print("PRESENT")
                        self.Delete_4.isHidden = false
//                        saveImage(number: "4", Image: ItemImage2)
                    }else{
                        print("EMPTY")
                    }
                    dismiss(animated: true, completion: nil)
                }else if(flag == 5){
                    ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage5.image = chosenImage
                    if(self.ItemImage2.image == chosenImage){
                        print("PRESENT")
                        self.Delete_5.isHidden = false
//                        saveImage(number: "5", Image: ItemImage2)
                    }else{
                        print("EMPTY")
                    }
                    dismiss(animated: true, completion: nil)
                }
            }
    //        dismiss(animated: true, completion: nil)
        }
    
    @IBAction func Accept(_ sender: Any) {
        spinner.show(in: self.view)
        let imageData: Data = ItemImage.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        let parameters: Parameters=[
            "user_id": userID,
            "main_category":Category.text!,
            "sub_category":Category.text!,
            "ad_detail":Addetail,
            "brand_material":BrandMaterial,
            "inner_material": InnerMaterial,
            "stock": Stock,
            "description": Description,
            "price": Price.text!,
            "max_order": MaxOrder.text!,
            "division": Division.text!,
            "postcode": PostCode.text!,
            "district": District.text!,
            "weight": Weight.text!,
            "photo": imageStr
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                if let result = response.result.value {
                    
                    self.spinner.dismiss(afterDelay: 3.0)
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    
                    if(self.ItemImage2.image == UIImage(named: "AddPhoto")){
                        print("EMPTY")
                    }else{
                        self.saveImage(number: "2", Image: self.ItemImage2)
                        print("SUCCESS 2")
                    }
                    
                    if(self.ItemImage3.image == UIImage(named: "AddPhoto")){
                        print("EMPTY")
                    }else{
                        self.saveImage(number: "3", Image: self.ItemImage3)
                        print("SUCCESS 3")
                    }
                    
                    if(self.ItemImage4.image == UIImage(named: "AddPhoto")){
                        print("EMPTY")
                    }else{
                        self.saveImage(number: "4", Image: self.ItemImage4)
//                        self.Delete_4.isHidden = false
                        print("SUCCESS 4")
                    }
                    
                    if(self.ItemImage5.image == UIImage(named: "AddPhoto")){
                        print("EMPTY")
                    }else{
                        self.saveImage(number: "5", Image: self.ItemImage5)
//                        self.Delete_5.isHidden = false
                        print("SUCCESS 5")
                    }
                    
                        
                    _ = self.navigationController?.popToRootViewController(animated: true)
                }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed to Save"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
