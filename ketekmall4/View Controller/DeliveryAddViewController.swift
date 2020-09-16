//
//  DeliveryAddViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 03/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class DeliveryAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Days: UITextField!
    @IBOutlet weak var ButtonAdd: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var USERID: String = ""
    var ITEMID: String = ""
    var ADDETAIL: String = ""
    var DIVISION: String = ""
    var DAYS: String = ""
    var PRICE: String = ""
    
    let URL_ADD = "https://ketekmall.com/ketekmall/add_delivery_partone.php"
    let URL_EDIT_DEL_STATUS = "https://ketekmall.com/ketekmall/edit_delivery_status.php"
    let division = ["Kuching", "Kota Samarahan", "Serian", "Sri Aman", "Betong", "Sarikei", "Sibu", "Mukah", "Bintulu", "Kapit", "Miri", "Limbang"]
    
    var DivisionPicker = UIPickerView()
    
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
        
        Division.text! = DIVISION
        Days.text! = DAYS
        Price.text! = PRICE
        
        Division.inputView = DivisionPicker
        DivisionPicker.dataSource = self
        DivisionPicker.delegate = self
        
        ButtonAdd.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
    @IBAction func Add(_ sender: Any) {
        spinner.show(in: self.view)
            let parameters: Parameters=[
                "user_id": USERID,
                "division": Division.text!,
                "price": Price.text!,
                "days": Days.text!,
                "item_id": ITEMID
                
            ]
            
            Alamofire.request(URL_ADD, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    if let result = response.result.value{
                        
                
                         if(self.lang == "ms"){
                             self.spinner.textLabel.text = "Successfully Added".localized(lang: "ms")
                             
                         }else{
                             self.spinner.textLabel.text = "Successfully Added".localized(lang: "en")
                            
                         }

                         self.spinner.show(in: self.view)
                         self.spinner.dismiss(afterDelay: 4.0)
                        
                        self.Division.text = ""
                        self.Price.text = ""
                        self.Days.text = ""
                        
                        let parameters: Parameters=[
                            "id": self.ITEMID
                        ]
                        
                        Alamofire.request(self.URL_EDIT_DEL_STATUS, method: .post, parameters: parameters).responseJSON
                            {
                                response in
                                if let result = response.result.value{
                                    let jsonData = result as! NSDictionary
                                    
                                     print("SUCCESS EDIT STATUS")
                                }else{
                                    print("FAILED")
                                }
                        }
                    }else{
                        print("FAILED")
                    }
                    
            }
        }
    
    func changeLanguage(str: String){
        ButtonAdd.setTitle("Add to Cart".localized(lang: str), for: .normal)
        
        ButtonCancel.setTitle("Add to Cart".localized(lang: str), for: .normal)
        
    }
        
        @IBAction func Cancel(_ sender: Any) {
             _ = navigationController?.popViewController(animated: true)
        }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return division.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return division[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Division.text = division[row]
}

}
