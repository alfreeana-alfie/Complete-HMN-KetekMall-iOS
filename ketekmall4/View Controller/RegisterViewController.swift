//
//  RegisterViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 27/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD

class RegisterViewController: UIViewController {
    
    let URL_REGISTER = "https://ketekmall.com/ketekmall/register.php";
    let URL_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png";
    let VERIFY = "0";
    let GENDER = "Female";
    
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var PhoneNumberView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var ConfirmPasswordView: UIView!
    
    @IBOutlet weak var NameImage: UIImageView!
    @IBOutlet weak var EmailImage: UIImageView!
    @IBOutlet weak var PhoneImage: UIImageView!
    @IBOutlet weak var PasswordImage: UIImageView!
    @IBOutlet weak var ConfirmPassImage: UIImageView!
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PhoneNo: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    @IBOutlet weak var PasswordStyle: UIButton!
    @IBOutlet weak var Border: UIView!
    
//    override func viewDidAppear(_ animated: Bool) {
//        ColorFunc()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PasswordStyle.layer.cornerRadius = 20
        Border.layer.cornerRadius = 2
        
        NameView.layer.cornerRadius = 5
        EmailView.layer.cornerRadius = 5
        PhoneNumberView.layer.cornerRadius = 5
        PasswordView.layer.cornerRadius = 5
        ConfirmPasswordView.layer.cornerRadius = 5
        
        NameImage.layer.cornerRadius = 5
        EmailImage.layer.cornerRadius = 5
        PhoneImage.layer.cornerRadius = 5
        PasswordImage.layer.cornerRadius = 5
        ConfirmPassImage.layer.cornerRadius = 5
        
        NameImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        EmailImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        PhoneImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        PasswordImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        ConfirmPassImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func ColorFunc(){
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        let l = CAGradientLayer()
        l.frame = self.PasswordStyle.bounds
        l.colors = [color1, color2]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 16
        PasswordStyle.layer.insertSublayer(l, at: 0)
    }
    
    @IBAction func Register(_ sender: Any) {
        spinner.show(in: self.view)
        if(Name.text == "" || Email.text == "" || PhoneNo.text == "" || Password.text == "" || ConfirmPassword.text == ""){
            
            self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
            self.spinner.textLabel.text = "Incomplete Information"
            self.spinner.show(in: self.view)
            self.spinner.dismiss(afterDelay: 3.0)
        }else if(Password.text != ConfirmPassword.text){
            self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
            self.spinner.textLabel.text = "Incorrect Password/Confirm Password"
            self.spinner.show(in: self.view)
            self.spinner.dismiss(afterDelay: 3.0)
        }else if(isValidPassword(testStr: Password.text!) && isValidPassword(testStr: ConfirmPassword.text!)){
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
                        self.spinner.dismiss(afterDelay: 3.0)
                        if let result = response.result.value {
                            let jsonData = result as! NSDictionary
                            print(jsonData.value(forKey: "message")!)
                            self.spinner.indicatorView = JGProgressHUDSuccessIndicatorView()
                            self.spinner.show(in: self.view)
                            let tabbar = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                                       if let navigator = self.navigationController {
                                           navigator.pushViewController(tabbar, animated: true)
                                    }
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
        let loginViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
                                    
        self.dismiss(animated: false, completion: nil)
    }
}
