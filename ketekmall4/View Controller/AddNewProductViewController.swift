//
//  AddNewProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 28/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class AddNewProductViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var AdDetail: UITextField!
    @IBOutlet weak var BrandMaterial: UITextField!
    @IBOutlet weak var InnerMaterial: UITextField!
    @IBOutlet weak var Stock: UITextField!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var MaxOrder: UITextField!
    @IBOutlet weak var UploadPhoto: UIImageView!
    
    @IBOutlet weak var UploadImage: UIButton!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    let URL_ADD = "https://ketekmall.com/ketekmall/products/uploadimg.php";
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        UploadImage.layer.cornerRadius = 5
        
        UploadImage.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        
        navigationItem.title = "Add New Product"
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
    
    @objc private func selectImage(sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        UploadPhoto.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Accept(_ sender: Any) {
        let imageData: Data = UploadPhoto.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        let parameters: Parameters=[
            "user_id": userID,
            "main_category":Category.text!,
            "sub_category":Category.text!,
            "ad_detail":AdDetail.text!,
            "brand_material":BrandMaterial.text!,
            "inner_material": InnerMaterial.text!,
            "stock": Stock.text!,
            "description": Description.text!,
            "price": Price.text!,
            "max_order": MaxOrder.text!,
            "division": Division.text!,
            "district": District.text!,
            "photo": imageStr
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
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
        self.dismiss(animated: false, completion: nil)
    }
}
