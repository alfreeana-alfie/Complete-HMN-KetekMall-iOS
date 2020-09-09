//
//  RegisterSellerViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class RegisterSellerViewController: UIViewController {
    
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_detail_seller.php"
    
    @IBOutlet weak var ICNOField: UITextField!
    @IBOutlet weak var BankNameField: UITextField!
    @IBOutlet weak var BankAccField: UITextField!
    @IBOutlet weak var ICView: UIView!
    @IBOutlet weak var BankNameView: UIView!
    @IBOutlet weak var BankAccView: UIView!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    var UserID: String = ""
    
    @IBAction func Accept(_ sender: Any) {
        let parameters: Parameters=[
            "id": UserID,
            "ic_no": ICNOField.text!,
            "bank_name": BankNameField.text!,
            "bank_acc": BankAccField.text!,
            "verification": "1"
        ]
        
        //Sending http post request
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                let boostAd = self.storyboard!.instantiateViewController(identifier: "AddNewProductViewController") as! AddNewProductViewController
                boostAd.userID = self.UserID
                if let navigator = self.navigationController {
                    navigator.pushViewController(boostAd, animated: true)
                }
                //                if let result = response.result.value{
                //                    let jsonData = result as! NSDictionary
                //
                //                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                //                        let user = jsonData.value(forKey: "read") as! NSArray
                //                    }
                //                }
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ICView.layer.cornerRadius = 5
        BankNameView.layer.cornerRadius = 5
        BankAccView.layer.cornerRadius = 5
        ButtonAccept.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
    }
    
}
