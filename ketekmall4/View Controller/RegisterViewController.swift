//
//  RegisterViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let URL_REGISTER = "https://ketekmall.com/ketekmall/register.php";
    let URL_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png";
    let VERIFY = "0";
    let GENDER = "Female";
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PhoneNo: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var PasswordStyle: UIButton!
    @IBOutlet weak var Border: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordStyle.layer.cornerRadius = 20
        Border.layer.cornerRadius = 2
    }
    
    @IBAction func Register(_ sender: Any) {
        
        if(isValidPassword(testStr: Password.text!)){
            let parameters: Parameters=[
                        "name":Name.text!,
                        "email":Email.text!,
                        "phone_no":PhoneNo.text!,
                        "password":Password.text!,
                        "birthday": "",
                        "gender": GENDER,
                        "photo": URL_PHOTO,
                        "verification": VERIFY,
                    ]
                    Alamofire.request(URL_REGISTER, method: .post, parameters: parameters).responseJSON
                    {
                        response in
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                        }
                    }
        }
        
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^.{8,}$")
        return passwordTest.evaluate(with: testStr)
    }

    
    @IBAction func GotoLogin(_ sender: Any) {
        let loginViewController = self.storyboard!.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
                                    
        self.dismiss(animated: false, completion: nil)
    }
}
